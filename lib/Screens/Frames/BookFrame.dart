import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'dart:async';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:grabApp/Screens/elements/PathWidget.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bookFrame(AppModel appModel, UniqueKey key) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        height: Globals.dheight * 18,
      ),
      Material(
        elevation: 8,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Container(
            width: Globals.width * 0.9,
            height: Globals.dheight * 96,
            decoration: BoxDecoration(
                color: Globals.foreWhite,
                borderRadius: BorderRadius.all(Radius.circular(26))),
            child: Stack(children: [
              Positioned.fill(
                  left: Globals.dwidth * 16,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: pathWidget(),
                  )),
              Positioned.fill(
                  left: Globals.dwidth * 48,
                  top: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: Globals.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Globals.dheight * 48,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 4 * Globals.dheight,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Pickup",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              fontSize: Globals.dwidth * 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 6 * Globals.dheight,
                                    child: Container(
                                      width: Globals.width,
                                      child: TextField(
                                        focusNode: appModel.widState.pF,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 18,
                                            color: Colors.black),
                                        controller:
                                            appModel.widState.pickupController,
                                        decoration:
                                            new InputDecoration.collapsed(
                                                hintStyle: TextStyle(
                                                    fontFamily: "Lato",
                                                    fontSize: 18,
                                                    color: Colors.grey),
                                                hintText:
                                                    'Kampoeng Makan Joglo 21'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: Globals.dheight * 48,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 4 * Globals.dheight,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Dropoff",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              fontSize: Globals.dwidth * 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 6 * Globals.dheight,
                                    child: Container(
                                      width: Globals.width,
                                      child: TextField(
                                        focusNode: appModel.widState.dF,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 18,
                                            color: Colors.black),
                                        controller:
                                            appModel.widState.dropoffController,
                                        decoration:
                                            new InputDecoration.collapsed(
                                                hintStyle: TextStyle(
                                                    fontFamily: "Lato",
                                                    fontSize: 18,
                                                    color: Colors.black),
                                                hintText: 'Berkah Warung'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      // color: Colors.red,
                    ),
                  ))
            ])),
      ),
      SizedBox(
        height: Globals.dheight * 16,
      ),
      Container(
          width: Globals.width * 0.9,
          height: Globals.dheight * 53,
          child: MaterialButton(
            elevation: 1,
            onPressed: () async {
              appModel.manualBook();
            },
            color: Colors.blue,
            splashColor: Colors.blue,
            highlightColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: Center(
                child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    appModel.bookState == BookState.NotBooked
                        ? "BOOK"
                        : appModel.bookState == BookState.Booking
                            ? "BOOKING"
                            : "ARRIVED",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: Globals.dwidth * 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                appModel.bookState == BookState.Booking
                    ? Positioned.fill(
                        right: 0,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : appModel.bookState == BookState.Arrived
                        ? Positioned.fill(
                            right: 0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                child: FaIcon(
                                  FontAwesomeIcons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
              ],
            )),
          )),
      // Container(
      //   width: Globals.width * 0.9,
      //   height: Globals.dheight * 53,
      //   decoration: BoxDecoration(
      //       color: Colors.blue,
      //       borderRadius: BorderRadius.all(Radius.circular(22))),
      //   child: InkWell(
      //       onTap: () {},
      //       borderRadius: BorderRadius.all(Radius.circular(22)),
      //       highlightColor: Colors.red,
      //       splashColor: Colors.red,
      //       child: Center(
      //           child: Text(
      //         "BOOK",
      //         textAlign: TextAlign.start,
      //         style: TextStyle(
      //             fontFamily: "Lato",
      //             fontSize: Globals.dwidth * 24,
      //             fontWeight: FontWeight.w600,
      //             color: Colors.white),
      //       ))),
      // ),

      // SizedBox(
      //   height: Globals.dheight * 18,
      // ),
    ],
  );
}
