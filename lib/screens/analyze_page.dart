import 'package:flutter/material.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key});

  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = [];

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _tasks.add(Task(title.trim()));
      _taskController.clear();
    });
  }

  void _analyzeTask(int index) async {
    setState(() => _tasks[index].isAnalyzing = true);
    await Future.delayed(const Duration(seconds: 1)); // (백엔드 응답 대기 가정)
    setState(() {
      _tasks[index]
        ..isAnalyzing = false
        ..isAnalyzed = true
        ..progress = 35 + (index * 10) % 60 // 예시값
        ..analysisText = "이 작업은 ${_tasks[index].progress.toStringAsFixed(0)}%의 피로도를 보입니다.\n집중 시간을 조절해보세요.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analyze Page")),
      body: Column(
        children: [
          // 🔹 전체 피로도
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "전체 피로도",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _tasks.isEmpty
                      ? 0
                      : _tasks
                              .map((t) => t.progress)
                              .fold<double>(0, (a, b) => a + b) /
                          (_tasks.length * 100),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),

          // 🔹 할 일 리스트 (카드형)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔸 제목 + 버튼/퍼센트
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            task.isAnalyzed
                                ? Text(
                                    "(${task.progress.toStringAsFixed(0)}%)",
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: task.isAnalyzing
                                        ? null
                                        : () => _analyzeTask(index),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.blueAccent, width: 1.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: task.isAnalyzing
                                        ? const SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.blueAccent,
                                            ),
                                          )
                                        : const Text(
                                            "분석하기",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // 🔸 분석 결과 텍스트
                        if (task.isAnalyzed)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              task.analysisText,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // 🔹 하단 고정 입력창
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: TextField(
          controller: _taskController,
          decoration: InputDecoration(
            hintText: "할 일 입력 후 Enter",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.keyboard_return_rounded,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          onSubmitted: _addTask,
        ),
      ),
    );
  }
}

class Task {
  String title;
  double progress;
  bool isAnalyzed;
  bool isAnalyzing;
  String analysisText;

  Task(this.title)
      : progress = 0,
        isAnalyzed = false,
        isAnalyzing = false,
        analysisText = '';
}
