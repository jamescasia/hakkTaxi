import 'package:grabApp/DataModels/DataPoint.dart';
import 'package:grabApp/ScopedModels/bookscreen_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:grabApp/DataModels/AppData.dart';
import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:grabApp/DataModels/BookingState.dart';
import 'package:location/location.dart';

import 'package:flutter_map/flutter_map.dart';

class AppModel extends Model {
  Screen curScreen = Screen.BookScreen;
  AppData appData;
  BookScreenModel bookScreenModel;
  // SelectScreenState selectScreenModel;
  // SummaryScreenState summaryScreenModel;
  // SummaryErrorScreenState summaryErrorScreenState;
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

      setInitialMapFocus();
    } else {
      setInitialMapFocus();
    }
  }

  setInitialMapFocus() async {
    print("Getting current Loc");
    setCurrentFocus(await getCurrentLocationCoordinates());
  }

  getCurrentLocationCoordinates() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return mapState.defaultFocus;
      }
    }
    _locationData = await location.getLocation();
    print(_locationData);
    return LatLng(_locationData.latitude, _locationData.longitude);
  }

  void setCurrentFocus(LatLng latlng) async {
    mapState.currentFocus = latlng;
    mapState.key = UniqueKey();
    notifyListeners();
  }

  void setCurrentZoom(double z) {
    mapState.currentZoom = z;
    mapState.key = UniqueKey();
    notifyListeners();
  }

  void bookScreenManualBook() async {
    await bookScreenModel.manualBook();
    setScreen(Screen.SummaryScreen);
  }

  void bookScreenSelectBook() {}
}

class MapState {
  LatLng defaultFocus = LatLng(-6.235, 106.858);
  LatLng currentFocus = LatLng(-6.235, 106.858);
  double currentZoom = 14.5;
  Key key = UniqueKey();
}

class SelectScreenState {}

class SummaryScreenState {}

class SummaryErrorScreenState {}
