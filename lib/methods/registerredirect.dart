import 'package:flutter/material.dart';

class Methods {
  redirectToRegister(contact, context) {
    print("Check $contact");
    if (contact == null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Your contact is not registered yet",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        child: Text("Click here to register"),
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register_page');
                        }),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
