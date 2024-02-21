import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/models/user.dart';

class Authentication {
  late final OAuth2Helper _helper;
  final client = OAuth2Client(
      authorizeUrl: authorizeURL,
      tokenUrl: tokenURL,
      redirectUri: dotenv.env['REDIRECTURL'].toString(),
      customUriScheme: dotenv.env['CUSTOMURISCHEME'].toString());

  Authentication() {
    _helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.authorizationCode,
      clientId: dotenv.env['CLIENT_ID'].toString(),
      clientSecret: secretId,
      scopes: ['public'],
    );
  }

  OAuth2Helper get helper => _helper;

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
    Uri url = Uri.parse('$intraURL/v2/users/$login');
    final response = await http
        .get(url, headers: {'Authorization': 'Bearer ${token!.accessToken}'});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Coalition> fetchCoalition(String login) async {
    AccessTokenResponse? token = await _helper.getToken();
    String url = '$intraURL/v2/users/$login/coalitions';
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${token!.accessToken}'});
    if (response.statusCode == 200) {
      return Coalition.fromJson(jsonDecode(response.body));
    } else {
      return Coalition(coverUrl: "null", color: const Color(0xff02cdd1));
    }
  }

  Future<List<Ranking>> fetchPromo(compus, city, date, page) async {
    try {
      AccessTokenResponse? token = await _helper.getToken();
      if (!token!.isExpired()) {
        Uri url = Uri.parse(
            '$intraURL/v2/cursus/21/cursus_users?&filter[campus_id]=$compus&range[begin_at]=${promo[city]![date]}&page=$page&per_page=20&sort=-level');
        final response = await http.get(url,
            headers: {'Authorization': 'Bearer ${token.accessToken}'});
        if (response.statusCode == 200) {
          return Ranking.fromListJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load Promo');
        }
      }
      throw Exception('token is expired');
    } catch (e) {
      print('error: $e');
      throw Exception(e);
    }
  }

  Future<User> fetchMe() async {
    try {
      AccessTokenResponse? token = await _helper.getToken();
      if (!token!.isExpired()) {
        final Uri url = Uri.parse("$intraURL/v2/me");
        final response = await http.get(url, headers: {
          'Authorization': 'Bearer ${token.accessToken}',
        });
        if (response.statusCode == 200) {
          return User.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load your info');
        }
      }
      throw Exception('token is expired');
    } catch (e) {
      print('error(fetchMe): $e');
      throw Exception(e);
    }
  }
}
