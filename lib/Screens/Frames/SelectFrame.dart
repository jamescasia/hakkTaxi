import 'package:flutter/material.dart';
import 'package:grabApp/DataModels/DataPoint.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:grabApp/DataModels/AppData.dart';

import 'package:grabApp/DataModels/Screens.dart';

import 'package:grabApp/Screens/elements/PathWidget.dart';

selectFrame(AppModel appModel) {
  int i = 0;
  return Container(
    // color: Colors.grey[50],
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: appModel.appData.dataPoints.map((dp) {
          dp.setOrder(i);
          i += 1;
          return DataPointCard(dp, appModel);
        }).toList(),
      ),
    ),
  );
}

class DataPointCard extends StatefulWidget {
  DataPoint dataPoint;
  AppModel appModel;
  // double pickupLat;
  // double dropoffLat;
  // double pickupLong;
  // double dropoffLong;
  // double duration;
  DataPointCard(this.dataPoint, this.appModel);
  @override
  _DataPointCardState createState() =>
      _DataPointCardState(this.dataPoint, this.appModel);
}

class _DataPointCardState extends State<DataPointCard> {
  // double pickupLat;
  // double dropoffLat;
  // double pickupLong;
  // double dropoffLong;
  // double duration;
  DataPoint dataPoint;
  AppModel appModel;

  _DataPointCardState(this.dataPoint, this.appModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Globals.dheight * 14,
          bottom: dataPoint.order == appModel.appData.dataPoints.length - 1
              ? Globals.dheight * 14
              : 0),
      child: Material(
        elevation: 3,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: InkWell(
          onTap: () {
            appModel.selectBook(dataPoint);
          },
          child: Container(
            width: Globals.width * 0.9,
            height: Globals.dheight * 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(28))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Pickup",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Globals.h3text)),
                      Text(dataPoint.pickupLat.toString(),
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                      Text(dataPoint.pickupLong.toString(),
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Dropoff",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Globals.h3text)),
                      Text(dataPoint.dropoffLat.toString(),
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                      Text(dataPoint.dropoffLong.toString(),
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Duration",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Globals.h3text)),
                      Text(dataPoint.duration.toString(),
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                      Text('',
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Globals.bgBlue)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
