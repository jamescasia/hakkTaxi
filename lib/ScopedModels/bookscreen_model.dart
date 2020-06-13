import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:grabApp/DataModels/Booking.dart';
import 'package:location/location.dart';

import 'package:grabApp/DataModels/BookingState.dart';

class BookScreenModel extends Model {
  String pickupFieldText = '';
  String dropoffFieldText = '';
  LatLng currentCenter;
  BookingState bookingState = BookingState.PickingPickupPoint;
  Booking booking = Booking();

  BookScreenModel() {}

  showCurrentLatLngPickup(LatLng pos) async {
    currentCenter = pos;
    pickupFieldText =
        "${currentCenter.latitude.toStringAsFixed(6)}, ${currentCenter.longitude.toStringAsFixed(6)}";
    notifyListeners();
  }

  showCurrentLatLngDropoff(LatLng pos) async {
    currentCenter = pos;
    dropoffFieldText =
        "${currentCenter.latitude.toStringAsFixed(6)}, ${currentCenter.longitude.toStringAsFixed(6)}";
    notifyListeners();
  }

  showCurrentPlacePickup(LatLng pos) {
    booking.pickupPoint = pos;
    // booking.pickupPlace
  }

  showCurrentPlaceDropoff(LatLng pos) {
    booking.dropoffPoint = pos;
  }

  manualBook() async {
    bookingState = BookingState.Driving;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    bookingState = BookingState.Arrived;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    bookingState = BookingState.NotBooked;
  }

  pressBookScreenButton() {
    if (bookingState == BookingState.PickingPickupPoint) {
      bookingState = BookingState.PickingDropoffPoint;
    } else if (bookingState == BookingState.PickingDropoffPoint) {
      bookingState = BookingState.NotBooked;
    } else if (bookingState == BookingState.NotBooked) {
      bookingState = BookingState.Driving;
      // call the api
    } else if (bookingState == BookingState.Driving) {
      bookingState = BookingState.Arrived;
    }
    notifyListeners();
  }

  // selectBook(DataPoint dataPoint) async {
  //   setScreen(Screen.BookScreen);
  //   bookingState = BookingState.Driving;
  //   notifyListeners();

  //   await Future.delayed(Duration(seconds: 2));

  //   bookingState = BookingState.Arrived;
  //   notifyListeners();

  //   await Future.delayed(Duration(seconds: 1));

  //   setScreen(Screen.SummaryErrorScreen);

  //   bookingState = BookingState.NotBooked;
  //   // setScreen(Screen.SummaryErrorScreen);
  // }
}
