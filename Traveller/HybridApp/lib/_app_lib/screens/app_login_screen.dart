import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_app_lib/app_page.dart';

import '../../data/models/login.dart';
import '../../interfaces/i_api_traveller.dart';
import '../../services/service_locator.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({super.key});

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  final ctrEmail = TextEditingController();
  final ctrPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formLoginKey,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: ctrEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: "Insert email",
                  icon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please insert email";
                  return null;
                },
              ),
              TextFormField(
                controller: ctrPassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: "Insert password",
                  icon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please insert password";
                  return null;
                },
              ),
              ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    if (_formLoginKey.currentState!.validate()) {
                      final _api = locator<
                          IApiTraveller>(); //Using the locator to get the Api interface

                      final login = Login(
                          email: ctrEmail.value.text,
                          password: ctrPassword.value.text);

                      if (await _api.checkLogin(login)) {
                        appPageNotifier.changePage(AppPages.home);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
