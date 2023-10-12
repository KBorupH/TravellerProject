import 'package:flutter/material.dart';
import 'package:traveller_app/_app_lib/notifiers/app_page_notifier.dart';

import '../../data/models/login.dart';
import '../../interfaces/i_api_traveller.dart';
import '../../services/service_locator.dart';
import '../notifiers/app_drawer_notifier.dart';

class AppRegisterScreen extends StatefulWidget {
  const AppRegisterScreen({super.key});

  @override
  State<AppRegisterScreen> createState() => _AppRegisterScreenState();
}

class _AppRegisterScreenState extends State<AppRegisterScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  final ctrEmail = TextEditingController();
  final ctrPassword = TextEditingController();
  final ctrRepeatedPassword = TextEditingController();

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
              TextFormField(
                controller: ctrRepeatedPassword,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: "Insert repeated password",
                  icon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please repeated insert password";

                  if (value != ctrPassword.value.text)
                    return "Passwords doesn't match";

                  return null;
                },
              ),
              ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    if (_formLoginKey.currentState!.validate()) {
                      final api = locator<
                          IApiTraveller>(); //Using the locator to get the Api interface

                      final login = Login(
                          email: ctrEmail.value.text,
                          password: ctrPassword.value.text);

                      if (await api.register(login)) {
                        appPageNotifier.changePage(AppPages.home);
                        appDrawerNotifier.changeLoginState(true);
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
