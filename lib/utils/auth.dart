import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/storage.dart';
import 'package:swifty_companion/utils/token.dart';

Future<bool> authorization() async {
  try {
    // Create an OAuth2Client
    final client = OAuth2Client(
        authorizeUrl: dotenv.env['AUTHORIZEURL'].toString(),
        tokenUrl: dotenv.env['TOKENURL'].toString(),
        redirectUri: dotenv.env['REDIRECTURL'].toString(),
        customUriScheme: dotenv.env['CUSTOMURISCHEME'].toString());

    // Create an OAuth2Helper
    const storage = FlutterSecureStorage();
    final helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.authorizationCode,
      clientId: dotenv.env['CLIENT_ID'].toString(),
      clientSecret: dotenv.env['SECRET_CODE'].toString(),
      scopes: ['public', 'profile'],
    );

    final response = await helper.getToken();
    if (response!.accessToken != null) {
      storage.write(key: 'AccessToken', value: response.accessToken);
      storage.write(key: 'RefreshToken', value: response.refreshToken);
    }
    return true;
  } catch (e) {
    print('ERROR AUTH: $e');
    return false;
  }
}

getUser(String login) async {
  final token = await MyStorage().read('AccessToken');
  var headers = {
    'Authorization': 'Bearer $token',
  };
  var request =
      http.Request('GET', Uri.parse('https://api.intra.42.fr/v2/users/$login'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

Future<User> fetchUser(String login) async {
  final checkToken = await checkToekn();
  if (checkToken == false) {
    await authorization();
  }
  final token = await MyStorage().read('AccessToken');
  String url = 'https://api.intra.42.fr/v2/users/$login';
  final response = await http
      .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

checkStorage() async {
  if (await MyStorage().read('AccessToken') == null) {
    authorization();
  }
}
