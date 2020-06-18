import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grabApp/DataModels/Screens.dart';

import 'package:grabApp/Screens/elements/PathWidget.dart';

errorCircle(double error, UniqueKey key) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        "Error",
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Globals.h3text),
      ),
      SizedBox(
        height: Globals.dheight * 7,
      ),
      Material(
        elevation: 16,
        shadowColor: Colors.black38,
        shape: CircleBorder(),
        child: Container(
          // width: Globals.dwidth * 160,
          height: Globals.dheight * 120,
          width: Globals.dheight * 120,
          decoration: BoxDecoration(
              color: Globals.goodGreen,
              borderRadius: BorderRadius.all(Radius.circular(300))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                Text(error.toString(),
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                SizedBox(width: 6 * Globals.dwidth),
                Text("sec",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white))
              ],
            ),
          ),
        ),
      )
    ],
    // children:
  );
}
