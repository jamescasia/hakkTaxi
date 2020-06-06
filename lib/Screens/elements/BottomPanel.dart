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
      return ClipRRect(
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
              Positioned(
                bottom: 0,
                child: Column(
                  children: <Widget>[
                    appModel.curScreen == Screen.BookScreen
                        ? BookFrame()
                        : appModel.curScreen == Screen.SelectScreen
                            ? SelectFrame()
                            : appModel.curScreen == Screen.SummaryScreen
                                ? SummaryFrame()
                                : SummaryErrorFrame()
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
