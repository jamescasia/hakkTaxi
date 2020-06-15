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

import 'package:flutter_map/flutter_map.dart';

class AppModel extends Model {
  Screen curScreen = Screen.BookScreen;
  AppData appData;
  BookScreenModel bookScreenModel;
  SelectScreenModel selectScreenModel;
  SummaryScreenModel summaryScreenModel;
  SummaryErrorScreenModel summaryErrorScreenModel;
  int i = 0;

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  MapState mapState = MapState();

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
      Booking booking = Booking(
          pickupPoint: bookScreenModel.pickupPoint,
          pickupPlace: bookScreenModel.pickupPlace,
          dropoffPoint: bookScreenModel.dropoffPoint,
          dropoffPlace: bookScreenModel.dropoffPlace,
          tripDuration: 404,
          fromSample: false);
      bookScreenManualBook(booking);

      notifyListeners();
    } else {
      await bookScreenModel.pressBookButton();
      notifyListeners();
    }
  }

  void bookScreenManualBook(Booking booking) async {
    mapState.zoomOutAndViewRoute(booking.pickupPoint, booking.dropoffPoint);
    await mapState.placePathBetweenPickupAndDropoff(
        booking.pickupPoint, booking.dropoffPoint);
    await bookScreenModel.manualBook(booking);
    summaryScreenModel.setBooking(booking);
    notifyListeners();
    // setScreen(Screen.SummaryScreen);

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

  void mapStatePlacePickupPointMarker(Marker marker) {
    mapState.placePickupPointMarker(marker);
    notifyListeners();
  }

  void mapStatePlaceDropoffPointMarker(Marker marker) {
    mapState.placeDropoffPointMarker(marker);
    notifyListeners();
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

  MapController mapController = MapController();
  initialize() {
    markers = [];
    pathPoints = [];
    setCurrentFocus(currentUserLocation);
  }

  setCurrentFocus(LatLng pos) {
    currentFocus = pos;
    mapController.move(currentFocus, currentZoom);
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

  placePathBetweenPickupAndDropoff(LatLng pickup, LatLng dropoff) async {
    var res = (await AppRequests.getPathBetweenPoints(pickup, dropoff));
    // print(res);

    var path = res['routes'][0]['legs'][0]['points'];
    for (dynamic p in path) {
      pathPoints.add(LatLng(p['latitude'], p['longitude']));
    }
    print(path);
    print(pathPoints);

//     pathPoints =
// // print('taeil');
//     print(temp);
  }

  zoomOutAndViewRoute(LatLng pickupPoint, LatLng dropoffPoint) {
    mapController.move(
        LatLng(0.5 * (pickupPoint.latitude + dropoffPoint.latitude),
            0.5 * (pickupPoint.longitude + dropoffPoint.longitude)),
        14);
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
