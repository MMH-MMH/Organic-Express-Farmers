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
    print("AUth $contact");
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
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[500],
        fontSize: 10,
      );
      if (data["success"]) {
        print("Posted Contact $contact ,");

        return [true, data["token"]];
      } else {
        print("Some error occurred");
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
      //   "isregistered": true,
      //   "contact": "+917408159898",
      //   "name": "Shashwat"
      // };
      print("Otp data -- $data and ${data['success']}");
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
      print("to send -- $send");

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
      print("Otp error");
      print(err.response);
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

      // Map<String, dynamic> userData = {
      //   "contact": "+917408159898",
      //   "name": "Shaswat gupta",
      //   "registered": true,
      //   "otp": "",
      //   "anotherNumber": "8299506687",
      //   "certificateNumber": "113",
      //   "currAdd": "10",
      //   "cropsList": ["rice", "wheat"],
      //   "farmingType": ["Organic"],
      //   "landSize": 10
      // };

      // String s = "";

      // for (String e in userData["cropsList"]) {
      //   s += e + ", ";
      // }

      // userData["cropsList"] = s.substring(0, s.length - 2);

      // s = "";

      // for (String e in userData["farmingType"]) {
      //   s += e + ", ";
      // }

      // userData["farmingType"] = s.substring(0, s.length - 2);

      // userData.forEach((key, value) {
      //   userData[key] = value.toString();
      // });

      print("Info - $userData");

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
      print("register data $data");
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
    print("getTypeList AuthService");
    var items = {
      "Seeds": ['S1', 'S2', 'S3', 'S4', 'S5'],
      "Bio-Fertilizers": ['BF1', 'BF2', 'BF3', 'BF4', 'BF5']
    };
    print("getTypeList AuthService $items");
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
    print("CropsStatus -- $sendData");

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
    print("CropsStatus -- $contact");

    Response res = await dio.post(
      uri + "/getCropStatus",
      data: {
        "contact": contact,
      },
    );

    var data = jsonDecode(res.toString());

    print("data: $data");

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
