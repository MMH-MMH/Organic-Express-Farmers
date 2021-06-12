import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  // String uri = "http://localhost:4000/authenticate";
  String uri =
      "https://organic-express-farmer-backend.herokuapp.com/authenticate";
  // String uri = "https://192.168.43.220:4000/authenticate";
  login(contact) async {
    try {
      // Response res = await dio.post(uri,
      //     data: {
      //       "contact": contact,
      //     },
      //     options: Options(contentType: Headers.formUrlEncodedContentType));

      // var data = jsonDecode(res.toString());
      var data = {
        "msg": "Otp Sent Succesfully",
        "token": "test",
        "success": true,
        "index": 2
      };
      print(data);
      Fluttertoast.showToast(
        msg: data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[500],
        fontSize: 10,
      );
      if (data["success"]) {
        return [true, data["token"]];
      } else {
        return [false];
      }
    } on DioError catch (err) {
      print("error - ${err.response.data}");
      Fluttertoast.showToast(
        msg: "server-side error, Please retry",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 15,
      );
      print("Auth error");
      print(err.response);
    }
  }

  verifyotp(otp, token) async {
    try {
      // dio.options.headers['Authorization'] = token;
      // Response res = await dio.post(uri + "/otpverify",
      //     data: {
      //       "otp": otp,
      //     },
      //     options: Options(contentType: Headers.formUrlEncodedContentType));
      // print("Otp response -- ${res.toString()}");
      // var data = jsonDecode(res.toString());
      var data = {
        "success": true,
        "msg": 'You are authorized',
        "isregistered": true,
        "contact": "+917408159898",
        "name": "Shashwat"
      };

      String send = "";
      if (data["success"]) {
        Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.grey[500],
          fontSize: 10,
        );
        send += "1";
      } else {
        Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[100],
          textColor: Colors.red,
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

      return send;
    } on DioError catch (err) {
      Fluttertoast.showToast(
        msg: err.response.data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
    }
  }

  getinfo(contact) async {
    try {
      Response res = await dio.post(uri + "/getinfo",
          data: {
            "contact": contact,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var userData = jsonDecode(res.toString());

      var data = {"success": true, "msg": "Success", "data": userData};

      if (data["success"]) {
        return userData;
      } else {
        Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.grey[500],
          fontSize: 10,
        );
        return "";
      }
    } on DioError catch (err) {
      // Fluttertoast.showToast(
      //   msg: err.response.data['msg'],
      // );
      Fluttertoast.showToast(
        msg: err.response.data["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
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
      // var data = {
      //   "success": true,
      //   "msg": "Invalid user Data",
      // };

      if (data["success"]) {
        Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
          textColor: Colors.grey[500],
          fontSize: 10,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[100],
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
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
    }
  }

  getTypeList(type) async {
    var items = {
      "Seeds": ['S1', 'S2', 'S3', 'S4', 'S5'],
      "Bio-Fertilizers": ['BF1', 'BF2', 'BF3', 'BF4', 'BF5']
    };

    return items;
  }

  sendRequest(sendData) async {
    var toSend = {"contact": sendData[1], "items": sendData[0]};

    Response res = await dio.post(
      uri + "/requestItems",
      data: {
        "data": toSend,
      },
    );

    var data = await jsonDecode(res.toString());

    // var data = {
    //   "success": true,
    //   "msg": "Request successfully sent",
    // };

    if (data["success"]) {
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[500],
        fontSize: 10,
      );
    } else {
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
    }
    return data["success"].toString();
  }

  updateStatus(sendData) async {
    Response res = await dio.post(
      uri + "/updateStatus",
      data: {
        "data": sendData,
      },
    );

    var data = await jsonDecode(res.toString());
    if (data["success"]) {
      Fluttertoast.showToast(
        msg: "Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[500],
        fontSize: 10,
      );
    }
  }

  getCropStatus(contact) async {
    Response res = await dio.post(
      uri + "/getCropStatus",
      data: {
        "contact": contact,
      },
    );

    var data = jsonDecode(res.toString());

    if (data["success"]) {
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[500],
        fontSize: 10,
      );
    } else {
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[100],
        textColor: Colors.red,
        fontSize: 10,
      );
    }
    return data["cropStatus"];
  }
}
