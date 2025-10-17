import 'package:flutter/material.dart';

enum Gender { male, female }

class AppState with ChangeNotifier {
  // 개인 정보
  Gender gender = Gender.male;
  int age = 0;
  int height = 0;
  int weight = 0;

  // 할 일 & 피로도 관련 정보

  void updateGender(Gender g) {
    gender = g;
    notifyListeners();
  }

  void updateAge(int a) {
    age = a;
    notifyListeners();
  }

  void updateHeight(int h) {
    height = h;
    notifyListeners();
  }

  void updateWeight(int w) {
    weight = w;
    notifyListeners();
  }

  void reset() {
    gender = Gender.male;
    age = 0;
    height = 0;
    weight = 0;
  }
}
