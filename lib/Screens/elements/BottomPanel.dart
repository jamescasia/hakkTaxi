import 'package:flutter/material.dart';
import 'package:grabApp/DataModels/Globals.dart';
import 'package:grabApp/ScopedModels/bookscreen_model.dart';
import 'package:grabApp/Screens/Frames/SelectFrame.dart';
import 'package:grabApp/Screens/Frames/SummaryErrorFrame.dart';
import 'package:grabApp/Screens/Frames/SummaryFrame.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/ScopedModels/app_model.dart';
import 'package:grabApp/Screens/Frames/BookFrame.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:grabApp/DataModels/AuthKeys.dart';
import 'package:grabApp/DataModels/Screens.dart';

import 'package:grabApp/DataModels/BookingState.dart';

class BottomPanel extends StatefulWidget {
  BottomPanel();
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel>
    with TickerProviderStateMixin {
  _BottomPanelState();
  AnimationController _markerAnimUpDownController;
  AnimationController _markerAnimLandController;
  Animation<Offset> _markerOffsetUpDownAnimation;
  var _markerOffsetLandAnimation;
  MapController mapController = MapController();
  bool picking = false;

  @override
  void initState() {
    super.initState();
    _markerAnimUpDownController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _markerOffsetUpDownAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.3),
    ).animate(CurvedAnimation(
      parent: _markerAnimUpDownController,
      curve: Curves.easeInOut,
    ));
// _markerAnimLandController = AnimationController(
    //   duration: const Duration(milliseconds: 800),
    //   vsync: this,
    // );
    _markerOffsetLandAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _markerAnimUpDownController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _markerAnimUpDownController.dispose();
    _markerAnimLandController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: Globals.height * 0.7,
              child: Stack(
                children: <Widget>[
                  Listener(
                    onPointerUp: (det) {
                      if (appModel.curScreen == Screen.BookScreen) {
                        if (appModel.bookScreenModel.bookingState ==
                            BookingState.PickingPickupPoint) {
                          appModel.bookScreenModel.showCurrentPlacePickup();
                          if (picking) {
                            _markerAnimUpDownController.forward();
                            picking = false;
                          }
                        } else if (appModel.bookScreenModel.bookingState ==
                            BookingState.PickingDropoffPoint) {
                          appModel.bookScreenModel.showCurrentPlaceDropoff();
                          // mapController.
                          if (picking) {
                            _markerAnimUpDownController.forward();
                            picking = false;
                          }
                        }
                      }
                    },
                    onPointerDown: (det) {
                      if (appModel.curScreen == Screen.BookScreen) {
                        if (!picking &&
                            (appModel.bookScreenModel.bookingState ==
                                    BookingState.PickingPickupPoint ||
                                appModel.bookScreenModel.bookingState ==
                                    BookingState.PickingDropoffPoint)) {
                          _markerAnimUpDownController.repeat(reverse: true);

                          picking = true;
                        }
                      }
                    },
                    child: FlutterMap(
                      key: appModel.mapState.key,
                      options: new MapOptions(
                        center: appModel.mapState.currentFocus,
                        zoom: appModel.mapState.currentZoom,
                        onPositionChanged: (position, hasGesture) {
                          if (appModel.curScreen == Screen.BookScreen) {
                            if (appModel.bookScreenModel.bookingState ==
                                BookingState.PickingPickupPoint) {
                              appModel.bookScreenModel
                                  .showCurrentLatLngPickup(position.center);
                            } else if (appModel.bookScreenModel.bookingState ==
                                BookingState.PickingDropoffPoint) {
                              appModel.bookScreenModel
                                  .showCurrentLatLngDropoff(position.center);
                            }
                          }
                        },
                      ),
                      mapController: mapController,
                      layers: [
                        new TileLayerOptions(
                          urlTemplate:
                              "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
                          additionalOptions: {
                            'subscriptionKey': AuthKeys.mapsAuthKey,
                            // 'z': '12',
                            // 'x': '12',
                          },
                        ),
                        new MarkerLayerOptions(
                          markers: appModel.mapState.markers,
                        )
                      ],
                    ),
                  ),
                  appModel.bookScreenModel.bookingState ==
                              BookingState.PickingDropoffPoint ||
                          appModel.bookScreenModel.bookingState ==
                              BookingState.PickingPickupPoint
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 52),
                            child: SlideTransition(
                              position: _markerOffsetUpDownAnimation,
                              child: Transform.scale(
                                scale: 1.23,
                                child: Container(
                                  height: 30,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                            width: 4,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: appModel.bookScreenModel
                                                            .bookingState ==
                                                        BookingState
                                                            .PickingPickupPoint
                                                    ? Colors.red
                                                    : Colors.lightBlue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(300)))),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: 19,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                color: appModel.bookScreenModel
                                                            .bookingState ==
                                                        BookingState
                                                            .PickingPickupPoint
                                                    ? Colors.red
                                                    : Colors.lightBlue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(300))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Center(
                      child: Container(width: 1, height: 1, color: Colors.red)),
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   excludeFromSemantics: true,
                  //   onScaleEnd: (details) {
                  //     // _markerAnimUpDownController.stop();
                  //     print("releasedO;");
                  //   },
                  // ),
                ],
              ),
            ),

            /**Backest Panel */

            // appModel.curScreen == Screen.BookScreen
            //     ? Positioned.fill(
            //         bottom: 0,
            //         child: Align(
            //           alignment: Alignment.bottomCenter,
            //           child: AnimatedContainer(
            //             curve: Curves.fastLinearToSlowEaseIn,
            //             duration: Duration(milliseconds: 500),
            //             height: backPanelSize(appModel.curScreen) +
            //                 50 * Globals.dheight,
            //             color: Colors.red.withAlpha(200),
            //             width: Globals.width*0.33,
            //           ),
            //         ))
            //     : SizedBox(),
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
                    // appModel.nextScreen();
                  },
                  child: Material(
                    elevation: 15,
                    child: AnimatedContainer(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 500),
                      width: Globals.width,
                      height: backPanelSize(appModel.curScreen),
                      color: Globals.bgBlue,
                      child: Stack(children: [
                        /**Title Bar */
                        Positioned(
                            top: 20 * Globals.dheight,
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
                                      color: Colors.blue.withAlpha(160),
                                      borderRadius: BorderRadius.circular(300)),
                                  child: InkWell(
                                    onTap: () {
                                      print("yawaw");
                                      // appModel.setScreen(Screen.SelectScreen);
                                      print(mapController.center);
                                    },
                                    highlightColor: Colors.red,
                                    splashColor: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(300)),
                                    child: Center(
                                      child: FaIcon(FontAwesomeIcons.hamburger,
                                          size: Globals.dwidth * 22,
                                          color: Colors.white),
                                    ),
                                  ),
                                ))
                            : SizedBox(height: 0),
                        Positioned(
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Globals.cornerRadius),
                                bottomLeft:
                                    Radius.circular(Globals.cornerRadius),
                                topRight: Radius.circular(Globals.cornerRadius),
                                bottomRight:
                                    Radius.circular(Globals.cornerRadius)),
                            /**Front Panel */
                            child: AnimatedContainer(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: Duration(milliseconds: 500),
                                color: Colors.grey[300],
                                width: Globals.width,
                                padding: EdgeInsets.all(Globals.dwidth * 2),
                                height: frontPanelSize(appModel.curScreen),
                                child: body(appModel, UniqueKey())

                                // Column(
                                //     mainAxisSize: MainAxisSize.max,
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: [
                                //       Center(
                                //           child: Container(
                                //               color: Colors.green,
                                //               width: 40,
                                //               height: 40)),
                                //       Center(
                                //           child: Container(
                                //               color: Colors.yellow,
                                //               width: 40,
                                //               height: 40)),

                                //       // Text(appModel.curScreen.toString())
                                //       // variable
                                //     ]),
                                ),
                          ),
                        ),

                        /**Floating panel between Back panel and Front Panel */

                        appModel.curScreen == Screen.SummaryErrorScreen ||
                                appModel.curScreen == Screen.SummaryScreen
                            ? Positioned.fill(
                                bottom: frontPanelSize(appModel.curScreen) -
                                    40 * Globals.dheight,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      // color: Colors.yellow.withAlpha(100),
                                      width: 180 * Globals.dwidth,
                                      height: 90 * Globals.dheight,
                                      child: Image.asset(
                                        "assets/app_icons/taxi.png",
                                        fit: BoxFit.contain,
                                      )),
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),

            /**Floating Panel */
            appModel.curScreen == Screen.BookScreen
                ? Positioned.fill(
                    bottom: frontPanelSize(appModel.curScreen) +
                        25 * Globals.dheight,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          // color: Colors.yellow.withAlpha(100),
                          width: 213 * Globals.dwidth,
                          height: 118 * Globals.dheight,
                          child: Image.asset(
                            "assets/app_icons/taxi.png",
                            fit: BoxFit.contain,
                          )),
                    ))
                : SizedBox(height: 0),
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
    return SizedBox(
      height: 0,
    );
}

body(AppModel appModel, Key key) {
  Screen curScreen = appModel.curScreen;
  if (curScreen == Screen.BookScreen) {
    return bookFrame(appModel, key);
  }
  if (curScreen == Screen.SummaryScreen) {
    return summaryFrame(appModel, key);
  }
  if (curScreen == Screen.SelectScreen) {
    return selectFrame(appModel);
  }
  if (curScreen == Screen.SummaryErrorScreen) {
    return summaryErrorFrame(appModel);
  }
}
