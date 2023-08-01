import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GaugeWidget extends StatefulWidget{
  const GaugeWidget({required this.currentHp, required this.maxHp, Key? key})
      : super(key: key);

  final int currentHp;
  final int maxHp;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  GauseWidgetState createState() => GauseWidgetState();
}


class GauseWidgetState extends State<GaugeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _widthAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget? child) {
              return Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: LinearProgressIndicator(
                    value: _controller.value * widget.currentHp / widget.maxHp,
                    valueColor:
                    AlwaysStoppedAnimation(getCurrentHpColor(widget.currentHp)),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    minHeight: 20,
                  ),
                ),
              );
            }),
          ],
        ));
  }

  Color getCurrentHpColor(int hp) {
    return Colors.amber;
  }
}