import 'dart:math';
import 'dart:ui';

import 'package:share/share.dart';
import 'GaugeWidget.dart';
import 'Question.dart';

import 'AdService.dart';
import 'ExamWidget.dart';
import 'MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'SoundManager.dart';
import 'main.dart';

class ExamResultWidget extends StatefulWidget {
  ExamResultWidget({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  _ExamResultWidgetPageState createState() => _ExamResultWidgetPageState();
}

class _ExamResultWidgetPageState extends State<ExamResultWidget>
    with TickerProviderStateMixin, RouteAware {
  final int minLevel = 0;
  late int maxLevel = 0;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

// _MyHomePageStateのbuildメソッド
//　状態を使いつつ組んだWidgetを返す(build関数)
  @override
  void initState() {
    super.initState();
    SoundManager.playArchive();
    AdService.loadInterstitial();
    maxLevel = calcMaxLevel();

    _animationController.forward(from: 0.0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPop() {
    super.didPop();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  int calcMaxLevel() {
    int l = 0;
    for (int i = 0; i < quizdata.length; i++) {
      List<int>? scoreList = quizdata.values.elementAt(i).scoreList;
      if (scoreList != null) {
        l += scoreList.reduce(max);
      }
    }
    return l;
  }

  Matrix4 _generateMatrix(Animation animation) {
    final value = lerpDouble(30.0, 0, animation.value);
    return Matrix4.translationValues(0.0, value!, 0.0);
  }

  Widget _buildwidget(Animation<double> animation, Widget child) {
    return FadeTransition(
        opacity: animation,
        child: Padding(
            padding: EdgeInsets.only(
                top: 20.w, bottom: 20.w, right: 50.w, left: 50.w),
            child: Transform(
              transform: _generateMatrix(_createAnimation(1)),
              child: child,
            )));
  }

  Widget ResultWidget() {
    Card titleWidget;
    Text bodyWidget;
    Image imageWidget;

    if (widget.score <= maxLevel * 0.1) {
      //高左脳派
      titleWidget = Card(
          color: Colors.deepOrangeAccent,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("陽キャ", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/gal_o_man.png'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2,
          "あなたは陽キャです。リアルが充実しておりチー牛とは真逆の人です。");
    } else if (widget.score <= maxLevel * 0.2) {
      titleWidget = Card(
          color: Colors.black12,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("普通キャ", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/normal.png'));

      bodyWidget = Text(
          style: Theme.of(context).textTheme.bodyText2,
          "あなたは普通の人です。特に際立った特徴はなく、陽キャ陰キャの中間の存在です。");
    } else if (widget.score <= maxLevel * 0.4) {
      titleWidget = Card(
          color: Colors.blueAccent,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("陰キャ", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/mukiryoku_man.png'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2,
          "あなたは陰キャです。内気ではありますが、チー牛と呼ばれるほどではありません。");
    } else if (widget.score <= maxLevel * 0.6) {
      titleWidget = Card(
          color: Colors.amber,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("チー牛", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/cheese.jpg'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2,
          "あなたはチー牛です。陰キャよりも内気で、周囲から浮いた存在になりがちです。");
    } else if (widget.score <= maxLevel * 0.8) {
      titleWidget = Card(
          color: Colors.amberAccent,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("メガチー牛", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/big_cheese.jpg'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2,
          "あなたはチー牛の中でも浮いている存在のメガチー牛です。このレベルだと生活にも支障がでています。ですが更生するチャンスはあります。まだ遅くありません。");
    } else if (widget.score <= maxLevel) {
      titleWidget = Card(
          color: Colors.yellow,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("キングオブチー牛", style: TextStyle(color: Colors.white))));

      imageWidget =
          Image(image: AssetImage('assets/images/king_of_cheese.png'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2,
          "あなたはチー牛の中でも抜きん出た存在のキングオブチー牛です。もう手遅れです。このまま我が道を歩み続けてください。");
    } else {
      titleWidget = Card(
          color: Colors.red,
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text("エラー", style: TextStyle(color: Colors.white))));

      imageWidget = Image(image: AssetImage('assets/images/cheese.jpg'));

      bodyWidget = Text(style: Theme.of(context).textTheme.bodyText2, "");
    }

    return Container(
        child: AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w),
                child: Column(children: [
                  Text("チー牛レベル",style: Theme.of(context).textTheme.bodyText2),
                  GaugeWidget(currentHp: widget.score, maxHp: maxLevel)
                ])),
            _buildwidget(
                _createAnimation(0),
                Padding(
                    padding: EdgeInsets.only(
                      left: 35.w,
                      right: 35.w,
                    ),
                    child: imageWidget)),
            _buildwidget(
                _createAnimation(2),
                Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: titleWidget)),
            _buildwidget(
                _createAnimation(4),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(10.w, 10.w)),
                      side: BorderSide(
                        color: Theme.of(context).primaryColorLight, //色
                        width: 2, //太さ
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: bodyWidget),
                    color: Theme.of(context).backgroundColor)),
          ],
        );
      },
    ));
  }

  Animation<double> _createAnimation(int delay) {
    assert(delay < 10);

    final actualDelay = 0.1 * delay;
    return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(actualDelay, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  Widget build(BuildContext context) {
    // UIの部分はここに書く。
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("あなたは...",
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Theme.of(context).primaryColorLight, height: 5.h),
            Expanded(
              child: SingleChildScrollView(child: ResultWidget()),
            ),
            Divider(color: Theme.of(context).primaryColorLight, height: 5.h),
            Container(
              child: SizedBox(
                  height: 70.h,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("戻る",
                              style: Theme.of(context).textTheme.bodyText2),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            side: BorderSide(
                                color: Theme.of(context).primaryColorLight,
                                width: 2.w),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 30.0.h, right: 30.h),
                        child: ElevatedButton(
                          onPressed: () {
                            Share.share(
                                '一緒に診断しよう！\nhttps://play.google.com/store/apps/details?id=com.NYStudio.chigyusindan');
                          },
                          child: Text("シェア",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColorDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColorLight,
                                  width: 2.w)),
                        ),
                      ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
