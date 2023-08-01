// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:chigyusindan/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chigyusindan/main.dart';

void main() {
  group('calc test', () {
    test("maxLevel", () {
      expect(calcMaxLevel(), 50);
    });
  });
}

int calcMaxLevel() {
  int l = 0;
  for (var question in quizdata.values) {
    List<int>? scoreList = question.scoreList;
    if (scoreList.isNotEmpty) {
      l += scoreList.reduce(max);
    }
  }
  return l;
}
