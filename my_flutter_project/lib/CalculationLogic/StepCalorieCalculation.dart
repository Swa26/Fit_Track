import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import '../DataStorage/PedometerCount.dart';

class StepCalorieCalculation extends ChangeNotifier {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '0', _steps = '0';
  double calorie = 0;
  double distanceCovered = 0;
  double distanceLeft = 1;
  bool distanceLeftStatus = false;
  late int weekDayIndex;

  List<PedometerCount> pedoTrackArray = List.filled(
      8,
      PedometerCount(
          currSteps: -1, totalSteps: -1, date: DateTime(2017, 9, 7)));

  void onStepCount(StepCount event) {
    print(event);
    print(event.timeStamp);

    _steps = event.steps.toString();
    calorie = (event.steps) * 0.04;
    distanceCovered = ((event.steps * 78) / 100000);
    distanceLeft = (distanceLeft - distanceCovered);
    if (distanceLeft <= 0) {
      distanceLeftStatus = true;
    }
    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    _status = event.status;
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    print(_status);
    notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps = 'Step Count not available';
    notifyListeners();
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    //getting week day index
    weekDayIndex = getCurrentWeekDayIndex();

    //checking if data is present in that index
    if (checkDataAtIndex(weekDayIndex)) {
      //if data is present
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(now);

      double pedoSteps = double.parse(_steps);

      if (formatter.format(pedoTrackArray[weekDayIndex].date) == formatted) {
        //if data is present and is of the same day,
        // simply overwrite with the same day record

        if (pedoSteps < pedoTrackArray[weekDayIndex].totalSteps) {
          pedoTrackArray[weekDayIndex].currSteps =
              pedoSteps + pedoTrackArray[weekDayIndex].currSteps;
          pedoTrackArray[weekDayIndex].totalSteps = pedoSteps;
        } else {
          pedoTrackArray[weekDayIndex].currSteps = pedoSteps -
              (pedoTrackArray[weekDayIndex].totalSteps) +
              pedoTrackArray[weekDayIndex].currSteps;
          pedoTrackArray[weekDayIndex].totalSteps = double.parse(_steps);
        }
      } else {
        //data is not of the same day
        //update the data with the previous day record
        if (pedoSteps < pedoTrackArray[weekDayIndex - 1].totalSteps) {
          pedoTrackArray[weekDayIndex].currSteps = pedoSteps;
          pedoTrackArray[weekDayIndex].totalSteps = pedoSteps;
          pedoTrackArray[weekDayIndex].date = DateTime.now();
        } else {
          pedoTrackArray[weekDayIndex].currSteps =
              pedoSteps - pedoTrackArray[weekDayIndex - 1].totalSteps;
          pedoTrackArray[weekDayIndex].totalSteps = double.parse(_steps);
          pedoTrackArray[weekDayIndex].date = DateTime.now();
        }
      }
    } else {
      //data is not present i.e. first time installation
      if (checkDataAtIndex(weekDayIndex - 1) == false) {
        //checking if data is not present on the previous day
        pedoTrackArray[weekDayIndex].totalSteps = double.parse(_steps);
        pedoTrackArray[weekDayIndex].currSteps = 0;
        pedoTrackArray[weekDayIndex].date = DateTime.now();
      } else {
        //if data is present on the previous day
        pedoTrackArray[weekDayIndex].totalSteps = double.parse(_steps);
        double pedoSteps = double.parse(_steps);
        pedoTrackArray[weekDayIndex].currSteps =
            (pedoSteps - pedoTrackArray[weekDayIndex - 1].totalSteps);
        pedoTrackArray[weekDayIndex].date = DateTime.now();
      }
    }
  }

  String getSteps() {
    return _steps;
  }

  String getStatus() {
    return _status;
  }

  int getCurrentWeekDayIndex() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return date.weekday;
  }

  bool checkDataAtIndex(int weekDayIndex) {
    if (pedoTrackArray[weekDayIndex].totalSteps == null) {
      return false;
    } else {
      return true;
    }
  }
}
