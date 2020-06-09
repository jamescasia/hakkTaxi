import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'elements/BottomPanel.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:grabApp/DataModels/AuthKeys.dart';

class GrabApp extends StatefulWidget {
  @override
  _GrabAppState createState() => _GrabAppState();
}

class _GrabAppState extends State<GrabApp> {
  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 793;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.height = MediaQuery.of(context).size.height;
    Globals.width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Globals.bgBlue.withAlpha(0),
        systemNavigationBarColor: Globals.bgBlue.withAlpha(0)
        // #61C350
        ));
    return ScopedModel<AppModel>(
      model: AppModel(),
      child:
          ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
        return ScrollConfiguration(
          behavior: ScrollBehaviour(),
          child: WillPopScope(
            onWillPop: () {
              appModel.setScreen(Screen.BookScreen);
            },
            child: Material(
                child: Scaffold(
                    body: Container(
              width: Globals.width,
              height: Globals.height,
              child: BottomPanel(),
            ))),
          ),
        );
      }),
    );
  }
}

class ScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
