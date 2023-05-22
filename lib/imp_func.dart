import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Theme/theme.dart';

Size mediaquery(context) => MediaQuery.of(context).size;

void go_to(context, screen) => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));

void go_toAnd_finish(context, screen) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) => screen));

IconButton PassIcon(Widget Icon, Function func) => IconButton(
      icon: Icon,
      color: Colors.black,
      onPressed: () => func(),
    );

AppBar appbar(context, {required String t, List<Widget>? act}) {
  return AppBar(
    title: Text(t, style: Titlestyle.copyWith(color: Colors.white)),
    titleSpacing: 5,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios)),
    actions: act,
  );
}

Future<bool?> showtoast(String txt) => Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.teal,
      textColor: Colors.white,
      fontSize: 16.0);
