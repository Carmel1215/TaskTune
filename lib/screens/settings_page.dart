import 'package:flutter/material.dart';

enum Gender { male, female }

enum UnitSystem { metric, imperial }

enum RmrFormula { mifflin, harris, katch }

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Gender _gender = Gender.male;

  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _bodyFatCtrl = TextEditingController();

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
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('기본 정보'),
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
            onSelectionChanged: (s) => setState(() => _gender = s.first),
          ),
          const SizedBox(height: 16),

          // 나이
          TextFormField(
            controller: _ageCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '나이',
              suffixText: '세',
              prefixIcon: Icon(Icons.cake_outlined),
            ),
          ),
          const SizedBox(height: 12),

          // 키
          TextFormField(
            controller: _heightCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '키',
              suffixText: 'cm',
              prefixIcon: Icon(Icons.height),
            ),
          ),
          const SizedBox(height: 12),

          // 체중
          TextFormField(
            controller: _weightCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '체중',
              suffixText: 'kg',
              prefixIcon: Icon(Icons.monitor_weight_outlined),
            ),
          ),

          const SizedBox(height: 24),
          const _SectionTitle('선택 입력'),
          const SizedBox(height: 8),

          // 체지방률
          TextFormField(
            controller: _bodyFatCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '체지방률',
              suffixText: '%',
              prefixIcon: Icon(Icons.percent),
              helperText: 'Katch–McArdle 사용 시 권장',
            ),
          ),
          const SizedBox(height: 36),

          const _SectionTitle('결과(미계산)'),
          const SizedBox(height: 8),

          Card(
            color: cs.surfaceContainerLow,
            child: const Column(
              children: [
                ListTile(
                  title: Text('RMR (kcal/day)'),
                  subtitle: Text('-'),
                  leading: Icon(Icons.local_fire_department_outlined),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text('RMR (kcal/min)'),
                  subtitle: Text('-'),
                  leading: Icon(Icons.timer_outlined),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(
                      shape: const StadiumBorder(), // 타원형
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
