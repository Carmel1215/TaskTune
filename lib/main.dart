import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasktune/data/app_state.dart';
import 'package:tasktune/screens/dashboard_page.dart';
import 'package:tasktune/screens/analyze_page.dart';
import 'package:tasktune/screens/settings_page.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 표시 제거
        title: 'TaskTune',
        theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        home: Scaffold(
          body: Row(
            children: [
              // --- 사이드바 ---
              SizedBox(
                width: 220,
                child: Column(
                  children: [
                    // 앱 로고
                    Container(
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/TestLogo_Battery.svg',
                            width: 50,
                            height: 50,
                          ),
                          /*Icon(Icons.assignment),*/
                          const SizedBox(width: 6),
                          const Text('TaskTune'),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    // 메뉴
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              MenuItem(
                                icon: Icons.dashboard_rounded,
                                label: '대시보드',
                                selected: selected == 0,
                                onTap: () => setState(() => selected = 0),
                              ),
                              MenuItem(
                                icon: Icons.auto_awesome,
                                label: '할 일 분석',
                                selected: selected == 1,
                                onTap: () => setState(() => selected = 1),
                              ),
                            ],
                          ),
                          // 설정
                          Column(
                            children: [
                              MenuItem(
                                icon: Icons.settings_rounded,
                                label: '설정',
                                selected: selected == 2,
                                onTap: () => setState(() => selected = 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // --- 구분선 ---
              Container(
                width: 1,
                color: Colors.grey,
              ),
              // --- 메인 화면 ---
              Expanded(
                child: IndexedStack(
                  index: selected,
                  children: [
                    const DashboardPage(),
                    const AnalyzePage(),
                    const SettingsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------- 메뉴 아이템 -------
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.grey.shade200 : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
