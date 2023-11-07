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
  // MyStorage().delete('AccessToken');
  // return;
  final token = await MyStorage().read('AccessToken');
  print('token: $token');
  if (token == null) {
    print('storage token is null!!');
    return false;
  }
  final ret = await getTokenInfo(token);
  print('ret: $ret');
  if (ret == 'Unauthorized') {
    print('Unauthorized');
    // return 'Unauthorized';
    return false;
  }
  final retJson = jsonDecode(ret);
  if (retJson['expires_in_seconds'] <= 60) {
    await authorization();
  }
  return true;
}
