import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_project/screens/StepCountPage.dart';
import 'package:my_flutter_project/view_model.dart';
import 'package:provider/provider.dart';

import 'CalculationLogic/StepCalorieCalculation.dart';

class LoginPage extends HookConsumerWidget {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,horizontal: 16
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/2.jpg',)),
                SizedBox(height: 20.0),
                Text(
                  'Welcome to Fit Track',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModelProvide.createUserWithEmailAndPassword(context, email.text, password.text);
                        email.clear();
                        password.clear();
                      },
                      child: Text('Register'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        viewModelProvide.signInWithEmailAndPassword(context, email.text, password.text).then((value) =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MultiProvider(
                                providers: [
                                  ListenableProvider(
                                    create: (ctx) => StepCalorieCalculation(),
                                  ),
                                ],
                                child: StepCountPage(),
                              ),),
                            ),
                        );
                        email.clear();
                        password.clear();
                      },
                      child: Text('Login'),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
