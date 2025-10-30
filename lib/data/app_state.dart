import 'package:flutter/material.dart';

enum Gender { male, female }

class Todo {
  String title;
  bool isDone;
  double fatigue;
  double kcal;

  Todo({
    required this.title,
    this.isDone = false,
    required this.fatigue,
    required this.kcal,
  });

  void toggle() => isDone = !isDone;
}

class AppState with ChangeNotifier {
  // 개인 정보
  Gender gender = Gender.male;
  int age = 0; // 년
  int height = 0; // cm
  int weight = 0; // kg
  double bodyFat = 0; // %

  // RMR 계산 결과
  double? rmrDay; // kcal/day
  double? rmrPerMin; // kcal/min

  // 할 일 목록
  List<Todo> todos = [];

  // ===== 프로필 업데이트 =====
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

  void updateBodyFat(double v) {
    bodyFat = v;
    notifyListeners();
  }

  // ===== RMR 계산 =====
  /// Katch–McArdle 우선, 없으면 Mifflin–St Jeor 사용
  double computeRmrDay({
    required Gender gender,
    required int age,
    required int heightCm,
    required int weightKg,
    double? bodyFatPct,
  }) {
    if (bodyFatPct != null && bodyFatPct >= 2 && bodyFatPct <= 70) {
      final lbm = weightKg * (1 - bodyFatPct / 100.0); // kg
      final r = 370.0 + 21.6 * lbm;
      return r.isFinite ? r : 0.0;
    }
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    final r = (gender == Gender.male) ? base + 5 : base - 161;
    return r.isFinite ? r : 0.0;
  }

  void updateRmr({required double rmrDay, required double rmrPerMin}) {
    this.rmrDay = rmrDay;
    this.rmrPerMin = rmrPerMin;
    notifyListeners();
  }

  /// 현재 저장된 신체정보로 즉시 재계산
  void recomputeAndUpdateRmr() {
    final r = computeRmrDay(
      gender: gender,
      age: age,
      heightCm: height,
      weightKg: weight,
      bodyFatPct: bodyFat > 0 ? bodyFat : null,
    );
    updateRmr(rmrDay: r, rmrPerMin: r > 0 ? r / 1440.0 : 0.0);
  }

  /// RMR 보장값(kcal/day). 저장된 RMR이 없으면 즉시 계산해 반환.
  double ensureRmrDay() {
    if (rmrDay != null && rmrDay! > 0) return rmrDay!;
    final r = computeRmrDay(
      gender: gender,
      age: age,
      heightCm: height,
      weightKg: weight,
      bodyFatPct: bodyFat > 0 ? bodyFat : null,
    );
    // 내부 상태는 보존하고, 호출자는 반환값만 사용
    return r;
  }

  /// MET과 시간(분)으로 칼로리 계산.
  /// net=true면 안정대사(1 MET)를 제외한 순소모량으로 계산.
  double computeKcalFromMet({
    required double met,
    required int minutes,
    bool net = false,
  }) {
    final r = ensureRmrDay(); // kcal/day
    final m = (net ? (met - 1) : met).clamp(0.0, 100.0);
    final t = minutes.clamp(0, 24 * 60);
    return r * (m * t) / 1440.0; // kcal
  }

  // ===== To-do 관리 =====
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

  void removeAt(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void toggleAt(int index) {
    todos[index].toggle();
    notifyListeners();
  }

  void updateTodoAt(
    int i, {
    String? title,
    bool? isDone,
    double? fatigue,
    double? kcal,
  }) {
    final t = todos[i];
    if (title != null) t.title = title;
    if (isDone != null) t.isDone = isDone;
    if (fatigue != null) t.fatigue = fatigue;
    if (kcal != null) t.kcal = kcal;
    notifyListeners();
  }

  // ===== 초기화 =====
  void settingReset() {
    gender = Gender.male;
    age = 0;
    height = 0;
    weight = 0;
    bodyFat = 0.0;
    rmrDay = null;
    rmrPerMin = null;
    todos.clear();
    notifyListeners();
  }
}
