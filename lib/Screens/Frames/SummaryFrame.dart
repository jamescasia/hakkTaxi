import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grabApp/DataModels/Screens.dart';

import 'package:grabApp/Screens/elements/PathWidget.dart';

import 'package:grabApp/Screens/elements/DurationCard.dart';
import 'package:grabApp/Screens/elements/DistanceCard.dart';

summaryFrame(AppModel appModel, UniqueKey key) {
  return Stack(
    children: <Widget>[
      Positioned.fill(
        top: Globals.dheight * 35,
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "XS-8452",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500]),
          ),
        ),
      ),
      Positioned.fill(
          top: Globals.dheight * 58,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    durationCard("01:28:32", UniqueKey()),
                    distanceCard("42.3", UniqueKey()),
                  ],
                ),
                SizedBox(
                  height: Globals.dheight * 18,
                ),
                Container(
                  width: Globals.width * 0.82,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      pathWidget(),
                      SizedBox(width: Globals.dwidth * 15),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pickup",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Globals.h3text),
                                  ),
                                  SizedBox(
                                    height: Globals.dheight * 0.2,
                                  ),
                                  Text("Kampoeng Makan Joglo 21",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Globals.h1text.withAlpha(230)))
                                ]),
                            SizedBox(
                              height: Globals.dheight * 10,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dropoff",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Globals.h3text),
                                  ),
                                  SizedBox(
                                    height: Globals.dheight * 0.2,
                                  ),
                                  Text("Berkah Warung",
                                      style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Globals.h1text.withAlpha(230)))
                                ])
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          )),
      Positioned(
        bottom: 16 * Globals.dheight,
        left: 25 * Globals.dheight,
        child: Material(
          elevation: 16,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(300))),
          child: Container(
            // width: Globals.dwidth * 160,
            height: Globals.dheight * 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(300))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Globals.dwidth * 6),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(300)),
                      child: Container(
                        width: Globals.dwidth * 53,
                        height: Globals.dwidth * 53,
                        color: Colors.black,
                        child: Image.asset("assets/images/driver.jpeg",fit:BoxFit.cover),
                      )),
                  SizedBox(
                    width: Globals.dwidth * 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Sam Sepiol",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 15,
                              color: Globals.h1text)),
                      Text("B-2412",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Globals.h1text)),
                    ],
                  ),
                  SizedBox(
                    width: Globals.dwidth * 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 16 * Globals.dheight,
        right: 16 * Globals.dheight,
        child: Container(
          height: Globals.dwidth * 66,
          width: Globals.dwidth * 66,
          child: MaterialButton(
            elevation: 1,
            onPressed: () {
              appModel.setScreen(Screen.BookScreen);
            },
            color: Colors.blue,
            splashColor: Colors.blue,
            highlightColor: Colors.blue,
            shape: CircleBorder(),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(300))),
            child: Center(
                child: FaIcon(
              FontAwesomeIcons.check,
              size: Globals.dwidth * 30,
              color: Colors.white,
            )),
          ),
        ),
      )
    ],
  );
}
