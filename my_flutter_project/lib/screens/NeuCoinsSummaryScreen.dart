// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_project/widgets/NueCoinTotalTodayCount.dart';

import '../widgets/BottomNavigation.dart';
import '../widgets/WeeklyEarnedCoins.dart';

class NeuCoinsSummaryScreen extends StatelessWidget {
  const NeuCoinsSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            '7 Days History',
            style: TextStyle(fontSize: 42),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeeklyEarnedCoins(day: 'Fri', coinsEarned: 1),
                      WeeklyEarnedCoins(day: 'Thu', coinsEarned: 2),
                      WeeklyEarnedCoins(day: 'Wed', coinsEarned: 3),
                      WeeklyEarnedCoins(day: 'Tue', coinsEarned: 4),
                      WeeklyEarnedCoins(day: 'Mon', coinsEarned: 5),
                      WeeklyEarnedCoins(day: 'Sun', coinsEarned: 2),
                      WeeklyEarnedCoins(day: 'Sat', coinsEarned: 3),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeuCoinTotalTodayCount(headingText: 'Total', value: 47),
                      NeuCoinTotalTodayCount(headingText: 'Today', value: 3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          currIndex: 1,
        ),
      ),
    );
  }
}
