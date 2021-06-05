import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  String uri = "http://localhost:5000/authenticate";
  login(contact) async {
    print("AUth");
    try {
      Response res = await dio.post(uri,
          data: {
            "contact": contact,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));

      var data = jsonDecode(res.toString());
      // var data = {
      //   "msg": "Otp Sent Succesfully",
      //   "token": "test",
      //   "success": true,
      //   "index": 2
      // };
      print(data);
      Fluttertoast.showToast(
        msg: data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 10,
      );
      if (data["success"]) {
        print("Posted Contact $contact ,");

        return data["token"];
      } else {
        print("Some error occurred");
      }
    } on DioError catch (err) {
      Fluttertoast.showToast(
        msg: err.response.data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10,
      );
      print("Auth error");
      print(err.response);
    }
  }

  verifyotp(otp, token) async {
    try {
      dio.options.headers['Authorization'] = token;
      Response res = await dio.post(uri + "/otpverify",
          data: {
            "otp": otp,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Otp response -- ${res.toString()}");
      var data = jsonDecode(res.toString());
      // var data = {
      //   "success": true,
      //   "msg": 'You are authorized',
      //   "isregistered": false,
      //   "contact": "+917408159898",
      //   "name": "abcd"
      // };
      print("Otp data -- $data and ${data['success']}");
      String send = "";
      if (data["success"]) {
        Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10,
        );
        send += "1";
      } else {
        Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 10,
        );
        send += "0";
      }
      if (data["isregistered"]) {
        send += "1";
      } else {
        send += "0";
      }

      send += data["contact"];
      send += " ";
      send += data["name"];
      print("to send -- $send");

      return send;
    } on DioError catch (err) {
      Fluttertoast.showToast(
        msg: err.response.data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10,
      );
      print("Otp error");
      print(err.response);
    }
  }

  getinfo(token) async {
    dio.options.headers['Authorization'] = token;
    try {
      Response res = await dio.post(uri + "/getinfo",
          data: {
            "token": token,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var data = jsonDecode(res.toString());

      if (data["success"]) {
        return [data["name"], data["contact"]];
      } else {
        return "";
      }
    } on DioError catch (err) {
      // Fluttertoast.showToast(
      //   msg: err.response.data['msg'],
      // );
      print("Otp error");
      print(err.response);
    }
  }

  register(userData) async {
    try {
      Response res = await dio.post(
        uri + "/register",
        data: {
          "data": userData,
        },
      );
      var data = jsonDecode(res.toString());
      print("register data $data");
      if (data["success"]) {
        Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green[800],
          textColor: Colors.white,
          fontSize: 10,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green[800],
          textColor: Colors.red,
          fontSize: 10,
        );
        return false;
      }
    } on DioError catch (err) {
      // Fluttertoast.showToast(
      //   msg: err.response.data['msg'],
      // );
      Fluttertoast.showToast(
        msg: err.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green[800],
        textColor: Colors.red,
        fontSize: 10,
      );
    }
  }
}
