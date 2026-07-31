import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomescreenAnimation {
  HomescreenAnimation._();
  static const List<String> morningAnimations = [
    'assets/morning_json/E V E.json',
    'assets/morning_json/Good Morning with Sun.json',
    'assets/morning_json/Good Morning.json',
    'assets/morning_json/robot.json',
    'assets/morning_json/time clock.json',
  ];

  static const List<String> afternoonAnimations = [
    'assets/afternoon_json/Hello with Waving Hand.json',
    'assets/afternoon_json/Hello, Hi.json',
    'assets/afternoon_json/Hello.json',
    'assets/afternoon_json/HiWelcome.json',
  ];

  static const List<String> eveningAnimations = [
    'assets/evening_json/cat halloween.json',
    'assets/evening_json/evening.json',
    'assets/evening_json/Hello with Waving Hand.json',
    'assets/evening_json/Hello.json',
  ];

  static const List<String> nightAnimations = [
    'assets/nights_json/E V E.json',
    'assets/nights_json/Hello.json',
    'assets/nights_json/json.json',
    'assets/nights_json/Sleepy Moon.json',
  ];
  static Widget getAnimation(DateTime now) {
    final random = Random();

    if (now.hour >= 5 && now.hour <= 11) {
      final animationPath =
          morningAnimations[random.nextInt(morningAnimations.length)];
      return Lottie.asset(
        animationPath,
        height: 60,
        width: 100,
        repeat: true,
        fit: BoxFit.cover,
      );
    } else if (now.hour >= 12 && now.hour <= 16) {
      final animationPath =
          afternoonAnimations[random.nextInt(afternoonAnimations.length)];
      return Lottie.asset(
        animationPath,
        height: 100,
        width: 150,
        repeat: true,
        fit: BoxFit.cover,
      );
    } else if (now.hour >= 17 && now.hour <= 20) {
      final animationPath =
          eveningAnimations[random.nextInt(eveningAnimations.length)];
      return Lottie.asset(
        animationPath,
        height: 100,
        width: 150,
        repeat: true,
        fit: BoxFit.cover,
      );
    } else {
      final animationPath =
          nightAnimations[random.nextInt(nightAnimations.length)];
      return Lottie.asset(
        animationPath,
        height: 100,
        width: 150,
        repeat: true,
        fit: BoxFit.cover,
      );
    }
  }
}
