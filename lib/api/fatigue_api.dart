import 'dart:convert';
import 'package:http/http.dart' as http;

// uvicorn server:app --reload --port 8000

class FatigueApi {
  FatigueApi(this.baseUrl);
  final String baseUrl; // 예: http://localhost:8000

  Future<double> predictFatigue({
    required double met,
    required int durationMin,
    required double preference01,
  }) async {
    final uri = Uri.parse('$baseUrl/predict');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'met': met,
        'duration_min': durationMin,
        'preference01': preference01,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['fatigue'] as num).toDouble();
  }
}
