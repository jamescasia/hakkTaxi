import 'package:flutter/material.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:grabApp/Screens/Frames/SelectFrame.dart';
import 'package:grabApp/Screens/Frames/SummaryErrorFrame.dart';
import 'package:grabApp/Screens/Frames/SummaryFrame.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/Screens/Frames/BookFrame.dart';

import 'package:grabApp/DataModels/Screens.dart';

class BottomPanel extends StatefulWidget {
  BottomPanel();
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  _BottomPanelState();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        child: Stack(
          children: <Widget>[
            /**Backest Panel */
            Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 300),
                  height:
                      backPanelSize(appModel.curScreen) + 50 * Globals.dheight,
                  color: Colors.red,
                  width: Globals.width,
                )),
            /**Back Panel */
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Globals.cornerRadius),
                  topRight: Radius.circular(Globals.cornerRadius),
                ),
                child: InkWell(
                  onTap: () {
                    appModel.nextScreen();
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(milliseconds: 300),
                    width: Globals.width,
                    height: backPanelSize(appModel.curScreen),
                    color: Globals.bgBlue,
                    child: Stack(children: [
                      /**Title Bar */
                      Positioned(
                          top: 24 * Globals.dheight,
                          left: 28 * Globals.dwidth,
                          child: titleWidget(appModel.curScreen)

                          // Text(
                          //   "Summary",
                          //   // variable
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(
                          //       fontFamily: "Lato",
                          //       fontSize: Globals.dwidth * 28,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.white),
                          // )
                          ),

                      /** Opt Button */

                      (appModel.curScreen == Screen.BookScreen)
                          ? Positioned(
                              top: 18 * Globals.dheight,
                              right: Globals.dwidth * 24,
                              child: Container(
                                width: Globals.dwidth * 44,
                                height: Globals.dwidth * 44,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(300)),
                                child: InkWell(
                                  onTap: () {
                                    print("yawaw");
                                  },
                                  highlightColor: Colors.red,
                                  splashColor: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(300)),
                                ),
                              ))
                          : SizedBox(),
                      Positioned(
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Globals.cornerRadius),
                              bottomLeft: Radius.circular(Globals.cornerRadius),
                              topRight: Radius.circular(Globals.cornerRadius),
                              bottomRight:
                                  Radius.circular(Globals.cornerRadius)),
                          /**Front Panel */
                          child: AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 300),
                            color: Globals.offWhite,
                            width: Globals.width,
                            padding: EdgeInsets.all(Globals.dwidth * 2),
                            height: frontPanelSize(appModel.curScreen),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Container(
                                          color: Colors.green,
                                          width: 40,
                                          height: 40)),
                                  Center(
                                      child: Container(
                                          color: Colors.yellow,
                                          width: 40,
                                          height: 40)),

                                  // Text(appModel.curScreen.toString())
                                  // variable
                                ]),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),

            /**Floating Panel */
            // Positioned.fill(
            //     bottom:
            //         frontPanelSize(appModel.curScreen) + 25 * Globals.dheight,
            //     child: Container(
            //       color: Colors.yellow.withAlpha(100),
            //       width: 200,
            //       height: 100,
            //     )),
            Positioned(
                bottom:
                    frontPanelSize(appModel.curScreen) + 25 * Globals.dheight,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow.withAlpha(100),
                      width: 200,
                      height: 100,
                    ),
                    SizedBox(width: Globals.width, height: 0)
                  ],
                ))
          ],
        ),
      );
    });
  }
}

titleWidget(Screen curScreen) {
  if (curScreen == Screen.SummaryErrorScreen ||
      curScreen == Screen.SummaryScreen)
    return Text(
      "Summary",
      // variable
      textAlign: TextAlign.start,
      style: TextStyle(
          fontFamily: "Lato",
          fontSize: Globals.dwidth * 28,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    );

  if (curScreen == Screen.SelectScreen)
    return Text(
      "Select",
      // variable
      textAlign: TextAlign.start,
      style: TextStyle(
          fontFamily: "Lato",
          fontSize: Globals.dwidth * 28,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    );
  else
    return SizedBox();
}

body(Screen curScreen) {
  if (curScreen == Screen.BookScreen) {

    
  }
}
