import 'package:grabApp/DataModels/DataPoint.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/DataModels/Screens.dart';
import 'package:grabApp/DataModels/AppData.dart';
import 'package:flutter/material.dart';

class AppModel extends Model {
  Screen curScreen = Screen.BookScreen;
  AppData appData;
  WidgetState widState;
  BookState bookState = BookState.NotBooked;
  int i = 0;

  AppModel() {
    appData = AppData();
    widState = WidgetState();
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

  void manualBook() async {
    bookState = BookState.Booking;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    bookState = BookState.Arrived;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    setScreen(Screen.SummaryScreen);

    bookState = BookState.NotBooked;
  }

  void selectBook(DataPoint dataPoint) async {
    setScreen(Screen.BookScreen);
    bookState = BookState.Booking;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    bookState = BookState.Arrived;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    setScreen(Screen.SummaryErrorScreen);

    bookState = BookState.NotBooked;
    // setScreen(Screen.SummaryErrorScreen);
  }
}

class WidgetState {
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropoffController = TextEditingController();
  FocusNode pF = FocusNode();
  FocusNode dF = FocusNode();
}

enum BookState { NotBooked, Booking, Arrived }
