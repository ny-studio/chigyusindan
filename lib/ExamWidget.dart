import 'dart:io';

import 'GaugeWidget.dart';
import 'Question.dart';

import 'MySharedPreference.dart';
import 'SoundManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ExamResultWidget.dart';

class ExamWidget extends StatefulWidget {
  ExamWidget({Key? key}) : super(key: key);

  @override
  _ExamWidgetPageState createState() => _ExamWidgetPageState();
}

class _ExamWidgetPageState extends State<ExamWidget> {
  List<Question> questions = [];
  int score = 0, _index = 0;

// _MyHomePageStateのbuildメソッド
//　状態を使いつつ組んだWidgetを返す(build関数)
  @override
  void initState() {
    super.initState();
    setQuestions();
  }

  void setQuestions() {
    questions = [...quizdata.values];
    questions.shuffle();
  }

  void nextQuizState() {
    _index++;
    setState(() {});
  }

  String getNumber() {
    return "Q" + (_index + 1).toString();
  }

  void next(int answer) {
    if ((_index + 1) < questions.length) {
      score += questions[_index].scoreList[answer];
      nextQuizState();
    } else {
      transitionToResultPage();
    }
  }

  void transitionToResultPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ExamResultWidget(score: score)));
  }

  Widget QuestionWidget(String question) {
    final imagePath = "assets/images/" + question;
    if (question.contains(".png")) {
      return Expanded(child: Image(image: AssetImage(imagePath)));
    } else {
      return Text(question, style: Theme.of(context).textTheme.headline6);
    }
  }

  Widget SelectButton(int answer) {
    return Padding(
      padding: EdgeInsets.only(top: 12.w, right: 20.h, left: 20.h, bottom: 0),
      child: SizedBox(
        width: double.maxFinite,
        height: 55.h,
        child: ElevatedButton(
          onPressed: () {
            SoundManager.playSelect();
            next(answer);
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.h),
            ),
            side: BorderSide(
                color: Theme.of(context).primaryColorDark, width: 2.w),
          ),
          child: Text(
            questions[_index].selectList[answer],
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UIの部分はここに書く。
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(children: [
            Container(
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GaugeWidget(currentHp: _index, maxHp: questions.length),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Theme.of(context).primaryColorLight, height: 5.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 25.h, left: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Q.", style: Theme.of(context).textTheme.headline6),
                    QuestionWidget(questions[_index].question)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 0.w, right: 15.h, left: 15.h, bottom: 20.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < questions[_index].selectList.length;
                              i++)
                            SelectButton(i),
                        ])))
          ]),
        ),
      ),
    );
  }
}
