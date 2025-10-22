import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OllamaClient {
  final String base;
  final String model;

  OllamaClient({
    this.base = 'http://127.0.0.1:11434',
    this.model = 'llama3.2:3b',
  });

  /// 대화 한 턴 스트리밍
  Stream<String> sendChatStream(List<Map<String, String>> messages) async* {
    final req = http.Request('POST', Uri.parse('$base/api/chat'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'model': model,
        'messages': messages,
        'stream': true,
      });
    final resp = await req.send();
    if (resp.statusCode != 200) {
      throw Exception('Ollama ${resp.statusCode}');
    }
    await for (final line
        in resp.stream
            .transform(utf8.decoder)
            .transform(const LineSplitter())) {
      if (line.trim().isEmpty) continue;
      final m = jsonDecode(line) as Map<String, dynamic>;
      final content = (m['message']?['content'] ?? '') as String;
      if (content.isNotEmpty) yield content; // 누적이 아닌 delta
      if (m['done'] == true) break;
    }
  }

  /// 누적 결과 한 번에
  Future<String> sendChatOnce(List<Map<String, String>> messages) async {
    final r = await http.post(
      Uri.parse('$base/api/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'messages': messages, 'stream': false}),
    );
    if (r.statusCode != 200) throw Exception('Ollama ${r.statusCode}');
    final j = jsonDecode(r.body) as Map<String, dynamic>;
    return (j['message']?['content'] ?? '') as String;
  }
}
