import 'package:flutter/material.dart';
import 'package:tasktune/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeadSection(),
            SummaryCard(
              fatigue: 1.0,
              done: 1,
              total: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class HeadSection extends StatelessWidget {
  const HeadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final w = ['월', '화', '수', '목', '금', '토', '일'][(now.weekday - 1) % 7];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}. ($w)',
          style: text.titleLarge!.copyWith(
            color: scheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '오늘도 파이팅!',
          style: text.headlineSmall,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final double fatigue;
  final int done;
  final int total;

  const SummaryCard({
    super.key,
    required this.fatigue,
    required this.done,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: CircularProgressIndicator(
                        value: fatigue,
                        strokeWidth: 10,
                        backgroundColor: scheme.surfaceContainerHighest
                            .withValues(
                              alpha: 0.4,
                            ),
                        valueColor: AlwaysStoppedAnimation(scheme.primary),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${(fatigue * 100).round()}%',
                      style: text.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오늘 진행률', style: text.titleMedium),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: total == 0 ? 0 : done / total,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$done / $total 완료', style: text.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
