import 'package:flutter/material.dart';

enum Gender { male, female }

class Todo {
  String title;
  bool isDone;
  double fatigue;

  Todo({
    required this.title,
    this.isDone = false,
    required this.fatigue,
  });

  void toggle() => isDone = !isDone;
}

class AppState with ChangeNotifier {
  // 개인 정보
  Gender gender = Gender.male;
  int age = 0;
  int height = 0;
  int weight = 0;

  // 할 일 & 피로도 관련 정보
  List<Todo> todos = [];

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

  void settingReset() {
    gender = Gender.male;
    age = 0;
    height = 0;
    weight = 0;
    todos.clear();
    notifyListeners();
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

  void toggleTodo(Todo todo) {
    todo.toggle();
    notifyListeners();
  }

  // 인덱스 기반(대시보드 편의용)
  void removeAt(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void toggleAt(int index) {
    todos[index].toggle();
    notifyListeners();
  }

  // 부분 업데이트
  void updateTodoAt(int i, {String? title, bool? isDone, double? fatigue}) {
    final t = todos[i];
    if (title != null) t.title = title;
    if (isDone != null) t.isDone = isDone;
    if (fatigue != null) t.fatigue = fatigue;
    notifyListeners();
  }
}
