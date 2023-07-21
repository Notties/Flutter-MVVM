import 'dart:io';

import 'package:flutter_mvvm/users_list/models/users_list_model.dart';
import 'package:flutter_mvvm/users_list/repository/api_status.dart';
import 'package:flutter_mvvm/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<Object> getUsersAPI() async {
    try {
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);
      if (SUCCESS_CODE == response.statusCode) {
        return Success(code: SUCCESS_CODE,response: usersListModelFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Response');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errorResponse: 'Unknow Error');
    }
  }
}
