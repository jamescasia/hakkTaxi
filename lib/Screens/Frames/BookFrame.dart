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
        child: Container(
          color: Globals.offWhite.withAlpha(0),
          width: Globals.width,
          padding: EdgeInsets.all(Globals.dwidth * 2),
          height: frontPanelSize(appModel.curScreen),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                    child:
                        Container(color: Colors.green, width: 40, height: 40)),
                Center(
                    child:
                        Container(color: Colors.yellow, width: 40, height: 40)),

                // Text(appModel.curScreen.toString())
                // variable
              ]),
        ),
      );
    });
  }
}
