import 'package:flutter/material.dart';

class log_in_structure extends StatelessWidget {
  log_in_structure({
    required this.backgrnd_image,
    required this.page_label,
    required this.page_description,
    required this.label_email,
    required this.label_password,
    required this.account,
    required this.sign_log_navigation,
    required this.routeName_button,
    required this.button_widget,
  });

  String backgrnd_image;
  String page_label;
  String page_description;
  String label_email;
  String label_password;
  String account;
  String sign_log_navigation;
  String routeName_button;
  Widget button_widget;

  static String username = "";
  static String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    backgrnd_image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    page_label,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    page_description,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.white24,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        username = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(top: 6),
                        prefixIcon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                        ),
                        labelText: label_email,
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.white24,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.multiline,
                      //maxLines: null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(top: 6),
                        prefixIcon: Icon(
                          Icons.gpp_good,
                          color: Colors.white,
                        ),
                        labelText: label_password,
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      account,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 15,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    navigator_button_widget(
                      sign_log: sign_log_navigation,
                      routeName: routeName_button,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.35,
                child: Card(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(
                    //horizontal: MediaQuery.of(context).size.width*0.1,
                    vertical: MediaQuery.of(context).size.width * 0.014,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: button_widget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class navigator_button_widget extends StatelessWidget {
  navigator_button_widget({
    required this.sign_log,
    required this.routeName,
  });

  String sign_log;
  String routeName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(
        sign_log,
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 15,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
