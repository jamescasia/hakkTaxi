import 'package:grabApp/DataModels/AppRequests.dart';
import 'package:grabApp/DataModels/Booking.dart';
import 'package:grabApp/DataModels/DataPoint.dart';
import 'package:grabApp/ScopedModels/bookscreen_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:grabApp/DataModels/AppData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:grabApp/DataModels/BookingState.dart';
import 'package:location/location.dart';
import 'package:grabApp/helpers/AnimatedMapController.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:math' as math;

class AppModel extends Model {
  Screen curScreen = Screen.BookScreen;
  AppData appData;
  BookScreenModel bookScreenModel;
  SelectScreenModel selectScreenModel;
  SummaryScreenModel summaryScreenModel;
  SummaryErrorScreenModel summaryErrorScreenModel;
  int i = 0;
  double dropoffMarkerOpacity = 0;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  MapState mapState = MapState();
  Booking booking;

  AppModel() {
    appData = AppData();
    mapState = MapState();
    bookScreenModel = BookScreenModel();
    summaryScreenModel = SummaryScreenModel();
    summaryErrorScreenModel = SummaryErrorScreenModel();

    requestPermission();
  }

  void nextScreen() {
    i += 1;
    i = i % 4;
    curScreen = Screen.values[i];
    notifyListeners();
  }

  void setScreen(screen) {
    curScreen = screen;
    notifyListeners();
  }

  void requestPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }

      await updateCurrentLocationCoordinates();
    } else {
      await updateCurrentLocationCoordinates();
    }
    bookScreenInitialize();
  }

  // setInitialMapFocus() async {
  //   print("Getting current Loc");
  //   var pos = await updateCurrentLocationCoordinates();
  //   bookScreenModel.showCurrentLatLngPickup(pos);
  //   bookScreenModel.showCurrentPlacePickup();
  //   mapStateSetCurrentFocus(pos);
  // }

  updateCurrentLocationCoordinates() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        mapState.currentUserLocation = mapState.defaultFocus;

        return mapState.defaultFocus;
      }
    }
    _locationData = await location.getLocation();
    mapState.currentUserLocation =
        LatLng(_locationData.latitude, _locationData.longitude);
  }

  void mapStateSetCurrentFocus(LatLng latlng) async {
    mapState.setCurrentFocus(latlng);
  }

  // void setCurrentZoom(double z) {
  //   mapState.currentZoom = z;
  //   mapState.key = UniqueKey();
  //   notifyListeners();
  // }

  void bookScreenPressBookButton() async {
    if (bookScreenModel.bookingState == BookingState.NotBooked) {
      bookScreenManualBook(booking);

      notifyListeners();
    } else {
      await bookScreenModel.pressBookButton();
      notifyListeners();
    }
  }

  getShortestPath(LatLng pickup, LatLng dropoff) async {
    List<LatLng> pathPoints = [];
    double dist = 123;
    try {
      var res = (await AppRequests.getPathBetweenPoints(pickup, dropoff));
      // print(res);

      var path = res['routes'][0]['legs'][0]['points'];
      dist = res['routes'][0]['legs'][0]['summary']['lengthInMeters'] / 1000.0;

      print(res);
      for (dynamic p in path) {
        pathPoints.add(LatLng(p['latitude'], p['longitude']));
      }
    } catch (e) {
      print(e);
      pathPoints = [];
      dist = 0.0;
    }

    booking.distance = dist;

    print(pathPoints);

    return pathPoints;
  }

  void bookScreenManualBook(Booking booking) async {
    if (booking.pickupPlace == "")
      booking.pickupPlace = await bookScreenModel.getPlace(booking.pickupPoint);
    if (booking.dropoffPlace == "")
      booking.dropoffPlace =
          await bookScreenModel.getPlace(booking.dropoffPoint);
    var target =
        mapState.zoomOutAndViewRoute(booking.pickupPoint, booking.dropoffPoint);

    mapState.animMapController.move(target.center, target.zoom);

    await mapState.placePathBetweenPickupAndDropoff(
        await getShortestPath(booking.pickupPoint, booking.dropoffPoint));
    mapState.replaceMarkers();

    notifyListeners();
    await bookScreenModel.manualBook(booking);
    summaryScreenModel.setBooking(booking);
    setScreen(Screen.SummaryScreen);

    mapState.zoomOutSummaryScreen(booking.pickupPoint, booking.dropoffPoint);

    // mapState.zoomOutAndViewRoute(booking.pickupPoint, booking.dropoffPoint);
    // // mapState.mapController.zoom -= 2;
    // mapState.mapController.move(LatLng, mapState.mapController.zoom -2);
    notifyListeners();

    // mapState.testZoomAndArea();

    // todo: feed booking to the next screen
  }

  void bookScreenSelectBook() {}

  void bookScreenInitialize() {
    mapState.initialize();
    bookScreenModel.initialize();

    bookScreenModel.showCurrentLatLngPickup(mapState.currentUserLocation);
    bookScreenModel.showCurrentPlacePickup();
    notifyListeners();
  }

  void mapStatePlacePickupPointMarker(Marker marker) async {
    mapState.placePickupPointMarker(marker);

    notifyListeners();

    await Future.delayed(Duration(milliseconds: 800));
    dropoffMarkerOpacity = 1.0;
    notifyListeners();
  }

  void mapStatePlaceDropoffPointMarker(Marker marker) {
    mapState.placeDropoffPointMarker(marker);

    dropoffMarkerOpacity = 0.0;
    booking = Booking(
        pickupPoint: bookScreenModel.pickupPoint,
        pickupPlace: bookScreenModel.pickupPlace,
        dropoffPoint: bookScreenModel.dropoffPoint,
        dropoffPlace: bookScreenModel.dropoffPlace,
        tripDuration: 404,
        fromSample: false);

    // mapState.zoomOutAndViewRoute(booking.pickupPoint, booking.dropoffPoint);

    var target =
        mapState.zoomOutAndViewRoute(booking.pickupPoint, booking.dropoffPoint);

    mapState.animMapController.move(target.center, target.zoom);
    notifyListeners();
  }

  void mapStateAddNewMarkers(Marker pmarker, Marker dmarker) {
    mapState.addNewMarkers(pmarker, dmarker);
    // notifyListeners();
  }
}

class MapState {
  LatLng defaultFocus = LatLng(-6.235, 106.858);
  LatLng currentFocus = LatLng(-6.235, 106.858);

  LatLng currentUserLocation = LatLng(-6.235, 106.858);
  double currentZoom = 14;
  Key key = UniqueKey();
  List<Marker> markers = [];
  List<LatLng> pathPoints = [];
  List<Marker> newMarkers = [];
  AnimatedMapController animMapController;
  MapController mapController = MapController();
  initialize() {
    markers = [];
    newMarkers = [];
    pathPoints = [];
    setCurrentFocus(currentUserLocation);
  }

  setCurrentFocus(LatLng pos) {
    currentFocus = pos;
    animMapController.move(currentFocus, currentZoom);
  }

  placePickupPointMarker(Marker marker) {
    // markers[0] = marker;
    markers.add(marker);
    // key = UniqueKey();
  }

  placeDropoffPointMarker(Marker marker) {
    // markers[1] = marker;
    markers.add(marker);
    // key = UniqueKey();
  }

  addNewMarkers(Marker pmarker, Marker dmarker) {
    newMarkers.add(pmarker);
    newMarkers.add(dmarker);
  }

  replaceMarkers() {
    markers = newMarkers;
  }

  placePathBetweenPickupAndDropoff(List<LatLng> p) async {
    pathPoints = p;

//     pathPoints =
// // print('taeil');
//     print(temp);
  }

  testZoomAndArea() {
    for (double i = 0; i < 200; i++) {
      printZoomAndArea(i);
    }
  }

  printZoomAndArea(double z) {
    mapController.move(LatLng(10.0, 128.0), z);
    print(
        "${z}, ${(mapController.bounds.northEast.longitude - mapController.bounds.northWest.longitude).abs() * (mapController.bounds.northEast.latitude - mapController.bounds.southEast.latitude).abs()}");
  }

  zoomOutSummaryErroScreen(LatLng pickupPoint, LatLng dropoffPoint) {
    if ((pickupPoint.longitude.sign != dropoffPoint.longitude.sign) &&
        (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs() > 180)) {
      double half =
          (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs()) / 2;

      var centerLong;
      if (pickupPoint.longitude.sign == 1.0) {
        if (pickupPoint.longitude + half > 180) {
          centerLong = -180 + (pickupPoint.longitude + half - 180);
        }
      } else {
        if (dropoffPoint.longitude + half > 180) {
          centerLong = -180 + (dropoffPoint.longitude + half - 180);
        }
      }

      animMapController.move(
          LatLng(
              0.5 * (pickupPoint.latitude + dropoffPoint.latitude), centerLong),
          mapController.zoom - -1.6);
    } else {
      animMapController.move(
          LatLng(0.5 * (pickupPoint.latitude + dropoffPoint.latitude),
              0.5 * (pickupPoint.longitude + dropoffPoint.longitude)),
          mapController.zoom - 1.6);
    }
  }

  zoomOutSummaryErrorScreen(LatLng pickupPoint, LatLng dropoffPoint) {
    if ((pickupPoint.longitude.sign != dropoffPoint.longitude.sign) &&
        (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs() > 180)) {
      double half =
          (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs()) / 2;

      var centerLong;
      if (pickupPoint.longitude.sign == 1.0) {
        if (pickupPoint.longitude + half > 180) {
          centerLong = -180 + (pickupPoint.longitude + half - 180);
        }
      } else {
        if (dropoffPoint.longitude + half > 180) {
          centerLong = -180 + (dropoffPoint.longitude + half - 180);
        }
      }

      animMapController.move(
          LatLng(
              0.5 * (pickupPoint.latitude + dropoffPoint.latitude), centerLong),
          mapController.zoom - 2);
    } else {
      animMapController.move(
          LatLng(0.5 * (pickupPoint.latitude + dropoffPoint.latitude),
              0.5 * (pickupPoint.longitude + dropoffPoint.longitude)),
          mapController.zoom - 2);
    }
  }

  zoomOutSummaryScreen(LatLng pickupPoint, LatLng dropoffPoint) {
    if ((pickupPoint.longitude.sign != dropoffPoint.longitude.sign) &&
        (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs() > 180)) {
      double half =
          (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs()) / 2;

      var centerLong;
      if (pickupPoint.longitude.sign == 1.0) {
        if (pickupPoint.longitude + half > 180) {
          centerLong = -180 + (pickupPoint.longitude + half - 180);
        }
      } else {
        if (dropoffPoint.longitude + half > 180) {
          centerLong = -180 + (dropoffPoint.longitude + half - 180);
        }
      }

      animMapController.move(
          LatLng(
              0.5 * (pickupPoint.latitude + dropoffPoint.latitude), centerLong),
          mapController.zoom - 1);
    } else {
      animMapController.move(
          LatLng(0.5 * (pickupPoint.latitude + dropoffPoint.latitude),
              0.5 * (pickupPoint.longitude + dropoffPoint.longitude)),
          mapController.zoom - 1);
    }
  }

  zoomOutAndViewRoute(LatLng pickupPoint, LatLng dropoffPoint) {
    List<LatLng> bounds = [pickupPoint, dropoffPoint];
    return mapController.fitBounds(LatLngBounds.fromPoints(bounds),
        options: FitBoundsOptions(
            padding: EdgeInsets.only(
          bottom: 110,
          left: 60,
          top: 90,
          right: 60,
        )));

    // if ((pickupPoint.longitude.sign != dropoffPoint.longitude.sign) &&
    //     (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs() > 180)) {
    //   double half =
    //       (pickupPoint.longitude.abs() + dropoffPoint.longitude.abs()) / 2;

    //   var centerLong;
    //   if (pickupPoint.longitude.sign == 1.0) {
    //     if (pickupPoint.longitude + half > 180) {
    //       centerLong = -180 + (pickupPoint.longitude + half - 180);
    //     }
    //   } else {
    //     if (dropoffPoint.longitude + half > 180) {
    //       centerLong = -180 + (dropoffPoint.longitude + half - 180);
    //     }
    //   }

    //   animMapController.move(
    //       LatLng(
    //           0.5 * (pickupPoint.latitude + dropoffPoint.latitude), centerLong),
    //       14);
    // } else {
    //   animMapController.move(
    //       LatLng(0.5 * (pickupPoint.latitude + dropoffPoint.latitude),
    //           0.5 * (pickupPoint.longitude + dropoffPoint.longitude)),
    //       14);
    // }
  }
}

class SelectScreenModel {}

class SummaryScreenModel extends Model {
  Booking booking;

  setBooking(Booking booking) {
    this.booking = booking;
  }
}

class SummaryErrorScreenModel extends Model {
  Booking booking;
}
