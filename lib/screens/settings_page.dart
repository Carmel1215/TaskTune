import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasktune/data/app_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  Gender _gender = Gender.male;

  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _bodyFatCtrl = TextEditingController();

  bool _inited = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_inited) return;
    final app = context.read<AppState>();
    _gender = app.gender;
    _ageCtrl.text = app.age == 0 ? '' : app.age.toString();
    _heightCtrl.text = app.height == 0 ? '' : app.height.toString();
    _weightCtrl.text = app.weight == 0 ? '' : app.weight.toString();
    _bodyFatCtrl.text = app.bodyFat == 0 ? '' : app.bodyFat.toString();
    _inited = true;
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _bodyFatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '기본 정보',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 성별
            Text('성별', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<Gender>(
              segments: const [
                ButtonSegment(
                  value: Gender.male,
                  label: Text('남성'),
                  icon: Icon(Icons.male),
                ),
                ButtonSegment(
                  value: Gender.female,
                  label: Text('여성'),
                  icon: Icon(Icons.female),
                ),
              ],
              selected: {_gender},
              onSelectionChanged: (s) {
                if (s.isEmpty) return;
                setState(() => _gender = s.first);
              },
            ),
            const SizedBox(height: 16),

            // 나이
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TextFormField(
                controller: _ageCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: '나이',
                  suffixText: '세',
                  prefixIcon: Icon(Icons.cake_outlined),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return '나이를 입력하세요';
                  final n = int.tryParse(v);
                  if (n == null) return '숫자만 입력하세요';
                  if (n < 1 || n > 120) return '1–120 범위로 입력하세요';
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12),

            // 키
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TextFormField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: '키',
                  suffixText: 'cm',
                  prefixIcon: Icon(Icons.square_foot),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return '키를 입력하세요';
                  final n = int.tryParse(v);
                  if (n == null) return '숫자만 입력하세요';
                  if (n < 50 || n > 250) return '50–250 범위로 입력하세요';
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12),

            // 체중
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TextFormField(
                controller: _weightCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: '체중',
                  suffixText: 'kg',
                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return '체중을 입력하세요';
                  final n = int.tryParse(v);
                  if (n == null) return '숫자만 입력하세요';
                  if (n < 20 || n > 300) return '20–300 범위로 입력하세요';
                  return null;
                },
              ),
            ),

            const SizedBox(height: 24),
            const _SectionTitle('선택 입력'),
            const SizedBox(height: 8),

            // 체지방률
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TextFormField(
                controller: _bodyFatCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,3}([.]\d{0,1})?$'),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: '체지방률',
                  suffixText: '%',
                  prefixIcon: Icon(Icons.percent),
                  helperText: 'Katch–McArdle 사용 시 권장',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return null; // 선택 입력
                  final x = double.tryParse(v);
                  if (x == null) return '숫자(소수 1자리)로 입력하세요';
                  if (x < 2 || x > 70) return '2–70% 범위로 입력하세요';
                  return null;
                },
              ),
            ),

            const SizedBox(height: 36),
            const _SectionTitle('결과'),
            const SizedBox(height: 8),

            // RMR 바인딩
            Consumer<AppState>(
              builder: (context, app, _) {
                final day = app.rmrDay;
                final perMin = app.rmrPerMin;
                return Card(
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('RMR (kcal/day)'),
                        subtitle: Text(
                          day == null ? '-' : day.toStringAsFixed(0),
                        ),
                        leading: const Icon(
                          Icons.local_fire_department_outlined,
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        title: const Text('RMR (kcal/min)'),
                        subtitle: Text(
                          perMin == null ? '-' : perMin.toStringAsFixed(2),
                        ),
                        leading: const Icon(Icons.timer_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: _onSave,
                      style: FilledButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('저장'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final age = int.tryParse(_ageCtrl.text);
    final height = int.tryParse(_heightCtrl.text);
    final weight = int.tryParse(_weightCtrl.text);
    final bodyFat = _bodyFatCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_bodyFatCtrl.text);

    if (age == null || height == null || weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('입력값을 확인하세요')),
      );
      return;
    }
    if (_bodyFatCtrl.text.trim().isNotEmpty && bodyFat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('체지방률 입력을 확인하세요')),
      );
      return;
    }

    final app = context.read<AppState>();
    app.updateGender(_gender);
    app.updateAge(age);
    app.updateHeight(height);
    app.updateWeight(weight);
    if (bodyFat != null) app.updateBodyFat(bodyFat);

    // RMR 계산 및 저장
    final rmrDay = app.computeRmrDay(
      gender: _gender,
      age: age,
      heightCm: height,
      weightKg: weight,
      bodyFatPct: bodyFat,
    );
    final rmrPerMin = rmrDay > 0 ? rmrDay / 1440.0 : 0.0;
    app.updateRmr(rmrDay: rmrDay, rmrPerMin: rmrPerMin);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('저장 및 RMR 계산 완료')),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
