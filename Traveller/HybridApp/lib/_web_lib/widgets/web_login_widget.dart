import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/data/models/account.dart';

class WebLoginWidget extends StatefulWidget {
  const WebLoginWidget({super.key});

  @override
  State<WebLoginWidget> createState() => _WebLoginWidgetState();
}

class _WebLoginWidgetState extends State<WebLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final ctrEmail = TextEditingController();
  final ctrPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Login'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
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
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            }),
        ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                late Account account = Account(email: ctrEmail.value.text, password: ctrPassword.value.text);
                //Add to bloc
                context.go('/tickets');
              }
            }),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
