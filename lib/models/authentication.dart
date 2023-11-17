import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/storage.dart';

class Authentication {
  late final OAuth2Helper _helper;
  final client = OAuth2Client(
      authorizeUrl: dotenv.env['AUTHORIZEURL'].toString(),
      tokenUrl: dotenv.env['TOKENURL'].toString(),
      redirectUri: dotenv.env['REDIRECTURL'].toString(),
      customUriScheme: dotenv.env['CUSTOMURISCHEME'].toString());

  Authentication() {
    _helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.authorizationCode,
      clientId: dotenv.env['CLIENT_ID'].toString(),
      clientSecret: dotenv.env['SECRET_CODE'].toString(),
      scopes: ['public', 'profile'],
    );
  }

  get helper => _helper;
  getToken() {
    return _helper.getToken();
  }

  Future<bool> checkToken() async {
    try {
      AccessTokenResponse? token = await _helper.getToken();
      if (token != null) {
        if (token.isExpired()) {
          await _helper.refreshToken(token);
          token = await _helper.getToken();
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User> fetchUser(String login) async {
    AccessTokenResponse? token = await _helper.getToken();
    if (token!.isExpired()) {
      await _helper.refreshToken(token);
      token = await _helper.getToken();
    }
    Uri url = Uri.parse('https://api.intra.42.fr/v2/users/$login');
    final response = await http
        .get(url, headers: {'Authorization': 'Bearer ${token!.accessToken}'});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Coalition> fetchCoalition(String login) async {
    final token = await MyStorage().read('AccessToken');
    String url = 'https://api.intra.42.fr/v2/users/$login/coalitions';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return Coalition.fromJson(jsonDecode(response.body));
    } else {
      return Coalition(
          coverUrl:
              "https://profile.intra.42.fr/assets/background_login-a4e0666f73c02f025f590b474b394fd86e1cae20e95261a6e4862c2d0faa1b04.jpg",
          color: const Color(0xff02cdd1));
    }
  }
}
