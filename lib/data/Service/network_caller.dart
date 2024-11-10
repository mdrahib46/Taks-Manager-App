import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/screens/signIn_screen.dart';

import '../../controller/authcontroller.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "token": AuthController.accessToken.toString(),
      };
      printRequest(url, null, headers);
      final Response response = await get(uri, headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthenticated user.!",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "token": AuthController.accessToken.toString()
      };
      debugPrint(url);
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthenticated user",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  /// Method for unauthenticated user moved to signIn page.
  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(

        ///this context comes from TaskManager APP's (apps.dart) Page
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }

  /// Method for Print User request
  static void printRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  ) {
    debugPrint("Request: \nURL: $url \nBODY: $body \nHeaders: $headers");
  }

  /// Method for Print request response
  static void printResponse(String url, Response response) {
    debugPrint(
        "URL: $url \n STATUS CODE: ${response.statusCode} \n BODY: ${response.body}");
  }
}
