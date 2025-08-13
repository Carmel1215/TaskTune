import 'package:flutter/material.dart';
import 'package:tasktune/models/task_item.dart';
import 'package:tasktune/services/today_task_service.dart';

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
            TodaySummaryCard(fatigue: 0.6, done: 1, total: 2),
            SizedBox(
              height: 16,
            ),
            TodayTaskCard(),
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

class TodaySummaryCard extends StatelessWidget {
  final double fatigue;
  final int done;
  final int total;

  const TodaySummaryCard({
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

class TodayTaskCard extends StatefulWidget {
  const TodayTaskCard({super.key});

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  late Future<List<TaskItem>> _future;
  final _service = TodayTaskService();

  @override
  void initState() {
    super.initState();
    _future = _service.fetchToday();
  }

  Future<void> _refresh() async {
    setState(() => _future = _service.fetchToday());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<TaskItem>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox.square(
                  dimension: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              );
            }
            if (snap.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오늘 할 일', style: text.titleMedium),
                  const SizedBox(height: 8),
                  Text('불러오기 실패: ${snap.error}', style: text.bodySmall),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _refresh,
                    child: const Text('다시 시도'),
                  ),
                ],
              );
            }

            final items = snap.data!;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('오늘 할 일', style: text.titleMedium),
                  const SizedBox(height: 8),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: Text('오늘 할 일이 없어요')),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 8),
                      itemBuilder: (context, i) {
                        final t = items[i];
                        return Row(
                          children: [
                            Checkbox(
                              value: t.done,
                              onChanged: (v) =>
                                  setState(() => t.done = v ?? false),
                            ),
                            Expanded(
                              child: Text(
                                t.title,
                                style: t.done
                                    ? text.bodyMedium!.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.5),
                                      )
                                    : text.bodyMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
