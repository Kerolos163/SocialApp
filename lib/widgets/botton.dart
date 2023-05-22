import 'package:flutter/material.dart';

import '../Theme/theme.dart';

class Mybutton extends StatelessWidget {
  Mybutton({Key? key, required this.label, required this.onTap,this.fcolor})
      : super(key: key);
  final String label;
  final Function onTap;
  Color? fcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Center(
        child: Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryClr
          ),
          child: Center(
            child: Text(
              label,
              style: Titlestyle.copyWith(fontSize: 14,color: fcolor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
