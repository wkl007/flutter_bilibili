import 'package:flutter/material.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:provider/provider.dart';

/// 暗黑主题
class DarkModelPage extends StatefulWidget {
  const DarkModelPage({Key? key}) : super(key: key);

  @override
  _DarkModelPageState createState() => _DarkModelPageState();
}

class _DarkModelPageState extends State<DarkModelPage> {
  static const items = [
    {"name": '跟随系统', "mode": ThemeMode.system},
    {"name": '开启', "mode": ThemeMode.dark},
    {"name": '关闭', "mode": ThemeMode.light},
  ];
  var _currentTheme;

  @override
  void initState() {
    super.initState();
    var themeMode = context.read<ThemeProvider>().getThemeMode();
    items.forEach((element) {
      if (element['mode'] == themeMode) {
        _currentTheme = element;
      }
    });
  }

  Widget _item(int index) {
    var theme = items[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(child: Text(theme['name'] as String)),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(Icons.done, color: primary),
            )
          ],
        ),
      ),
    );
  }

  void _switchTheme(int index) {
    var theme = items[index];
    context.read<ThemeProvider>().setTheme(theme['mode'] as ThemeMode);
    setState(() {
      _currentTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('夜间模式')),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: items.length,
      ),
    );
  }
}
