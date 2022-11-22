import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

late String username;
late String password;
bool spinner = false;

class log_sign_structure extends StatelessWidget {
  log_sign_structure(
      {Key? key, required this.label_email,
      required this.label_password,
      required this.assetimage,
      required this.page_label,
      required this.page_description,
      required this.account,
      required this.button_widget,
      required this.log_sign_page_button}) : super(key: key);
  String label_email;
  String label_password;
  String assetimage;
  String page_label;
  String page_description;
  String account;
  Widget button_widget;
  Widget log_sign_page_button;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: SafeArea(
                    child: Image.asset(assetimage, fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                  child: Text(
                    page_label,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 30, fontFamily: 'Mukta'),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    page_description,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 15, fontFamily: 'Mukta'),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  color: Colors.white24,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        username = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.only(top: 8),
                          isCollapsed: true,
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          labelText: label_email,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  color: Colors.white24,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          border:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.only(top: 8),
                          prefixIcon: const Icon(
                            Icons.gpp_good,
                            color: Colors.white,
                          ),
                          labelText: label_password,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      account,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: 'Mukta'),
                    ),
                    log_sign_page_button
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: button_widget,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
