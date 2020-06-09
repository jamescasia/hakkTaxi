import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grabApp/DataModels/Screens.dart';

import 'package:grabApp/Screens/elements/PathWidget.dart';

distanceCard(String distance, UniqueKey key) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        "Distance",
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
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Container(
          width: Globals.dheight * 120,
          height: Globals.dheight * 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(distance,
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Globals.h1text)),
                  SizedBox(
                    width: 6*Globals.dwidth
                  ),
                  Padding(
                    padding:   EdgeInsets.only(bottom: 3*Globals.dheight),
                    child: Text("km",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Globals.h1text)),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ],
    // children:
  );
}
