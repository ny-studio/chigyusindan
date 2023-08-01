import 'MySharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingWidget extends StatefulWidget {
  SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetPageState createState() => _SettingWidgetPageState();
}

class _SettingWidgetPageState extends State<SettingWidget> {
  bool _sound = true;
  int _limit = 100;

// _MyHomePageStateのbuildメソッド
//　状態を使いつつ組んだWidgetを返す(build関数)
  @override
  void initState() {
    super.initState();
    initParams();
  }

  void initParams() async {
    _limit = await MySharedPreference.getPrefsLimit();
    _sound = await MySharedPreference.getPrefsSound();
    setState(() {});
  }

  void incrementLimit() async {
    MySharedPreference.setPrefsLimit(++_limit);
    setState(() {});
  }

  void decrementLimit() async {
    if (_limit > 5) {
      MySharedPreference.setPrefsLimit(--_limit);
      setState(() {});
    }
  }

  void setSoundMode(bool value) async {
    _sound = !_sound;
    MySharedPreference.setPrefsSound(_sound);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // UIの部分はここに書く。
    return Scaffold(
      appBar:
          AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text("設定",style:Theme.of(context).appBarTheme.titleTextStyle),
          ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.w, left: 25.h, right: 30.h),
              child: Row(children: [
                Expanded(
                    child: Text(
                  "効果音",
                      style: Theme.of(context).textTheme.headline6,
                )),
                CupertinoSwitch(
                    value: _sound,
                    onChanged: (value) {
                      setSoundMode(value);
                    })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
