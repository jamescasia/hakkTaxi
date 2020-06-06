import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';

class BookFrame extends StatefulWidget {
  @override
  _BookFrameState createState() => _BookFrameState();
}

class _BookFrameState extends State<BookFrame> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Globals.cornerRadius),
            bottomLeft: Radius.circular(Globals.cornerRadius),
            topRight: Radius.circular(Globals.cornerRadius),
            bottomRight: Radius.circular(Globals.cornerRadius)),
        child: AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 300),
          color: Globals.offWhite,
          width: Globals.width,
          padding: EdgeInsets.all(Globals.dwidth * 2),
          height: frontPanelSize(appModel.curScreen),
          child: Column(children: [
            Text(appModel.curScreen.toString())
            // variable
          ]),
        ),
      );
    });
  }
}
