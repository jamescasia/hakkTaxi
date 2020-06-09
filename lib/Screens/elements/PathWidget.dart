import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';

import 'package:grabApp/DataModels/Screens.dart';

pathWidget() {
  return Container(
    height: 80,
    width: 20,
    // color: Colors.blue,
    child: Stack(children: [
      Positioned(
        top: 0,
        child: Center(
          child: Container(
            height: 60,
            width: 20,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                    height: 0,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Container(
                    color: Globals.dashBlue,
                    width: 4,
                    height: 5,
                  ),
                ]),
          ),
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
            width: Globals.dwidth * 20,
            height: Globals.dwidth * 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(300)),
                gradient: LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: [
                    Globals.pickerUIRedStart,
                    Globals.pickerUIYellowEnd,
                  ],
                ))),
      ),
      Positioned.fill(
        bottom: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: Globals.bgBlue,
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ),
      Positioned(
        bottom: 0,
        child: Container(
          width: Globals.dwidth * 20,
          height: Globals.dwidth * 20,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(45 / 360),
                    child: Container(
                      width: Globals.dwidth * 14,
                      height: Globals.dwidth * 14,
                      color: Globals.accentBlue,
                    ),
                  ),
                ),
              ),
              Container(
                  width: Globals.dwidth * 20,
                  height: Globals.dwidth * 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(300)),
                      gradient: LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: [
                          Globals.bgBlue,
                          Globals.accentBlue,
                        ],
                      ))),
              Center(
                child: Container(
                    width: Globals.dwidth * 8,
                    height: Globals.dwidth * 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(300)),
                    )),
              ),
            ],
          ),
        ),
      )
    ]),
  );
}
