import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}