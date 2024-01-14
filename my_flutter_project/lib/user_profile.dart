import 'components.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final Provider = ref.watch(stateProvider);
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  _HomeState createState() => _HomeState();
}

final ss = username.split('@')[0];
String uname = ss.toString().capitalizeS();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print(ss);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffedccee),
              Color(0xffcceeed),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              OpenSans(
                text: 'Hello $uname',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.0,
              ),
              Image.network(
                'https://cdn2.iconfinder.com/data/icons/membership-account-outline/200/coder-512.png',
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              OpenSans(
                text: 'Email: $username',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalizeS() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
