import 'package:flutter/material.dart';
import 'package:sutix_app/services/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      SignInSignUpResult result = await AuthServices.signUp(
                          "supardi9512@gmail.com",
                          "password123",
                          "Supardi",
                          ["Action", "Horror", "Music", "Drama"],
                          "Korean");

                      if (result.user == null) {
                        print(result.message);
                      } else {
                        print(result.user.toString());
                      }
                    },
                    child: const Text("Sign Up")),
                ElevatedButton(
                    onPressed: () async {
                      SignInSignUpResult result = await AuthServices.signIn(
                        "supardi9512@gmail.com",
                        "password123",
                      );

                      if (result.user == null) {
                        print(result.message);
                      } else {
                        print(result.user.toString());
                      }
                    },
                    child: const Text("Sign In"))
              ],
            ),
          ),
        ));
  }
}
