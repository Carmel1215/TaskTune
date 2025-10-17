import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _SettingsItem(
              title: 'test',
            ),
            _SettingsItem(
              title: 'test',
            ),
            _SettingsItem(
              title: 'test',
            ),
            _SettingsItem(
              title: 'test',
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatefulWidget {
  final String title;

  const _SettingsItem({
    super.key,
    required this.title,
  });

  @override
  State<_SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<_SettingsItem> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      value: _isOn,
      onChanged: (bool value) {
        setState(() {
          _isOn = value;
        });
      },
    );
  }
}
