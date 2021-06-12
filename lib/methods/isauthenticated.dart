import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class Methods {
  LocalStorage storage = LocalStorage('organic');

  bool isAuthenticated() {
    var contact = storage.getItem('contact');
    return (contact != null);
  }

  void logout(context) {
    storage.clear();
    print(
        "Logout \n Contact - ${storage.getItem('contact') == null ? "null" : "In"}");
    Navigator.of(context).pushNamed('/');
  }
}
