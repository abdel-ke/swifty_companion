import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swifty_companion/utils/auth.dart';
import 'package:swifty_companion/utils/storage.dart';

getTokenInfo(String token) async {
  final uri = Uri.parse('https://api.intra.42.fr/oauth/token/info');
  final response = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return response.reasonPhrase;
  }
}

Future<bool> checkToekn() async {
  final token = await MyStorage().read('AccessToken');
  if (token == null) {
    print('storage token is null!!');
    return false;
  }
  final ret = await getTokenInfo(token);
  if (ret == 'Unauthorized') {
    print('Unauthorized !!');
    return await authorization();
  } else {
    final retJson = jsonDecode(ret);
    if (retJson['expires_in_seconds'] <= 60) {
      return await authorization();
    }
  }
  return true;
}
