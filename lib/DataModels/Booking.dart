import 'package:latlong/latlong.dart';

class Booking {
  LatLng pickupPoint;
  String pickupPlace = "";
  LatLng dropoffPoint;
  String dropoffPlace = "";
  Duration tripDuration = Duration(seconds: 0);
  double distance = 0.0;
  bool fromSample = false;
  int hourOfDay;
  int dayOfWeek;
  int pingtimestamp = 0;

  Duration realDuration = Duration(seconds: 0);
  Booking(
      {this.pickupPoint,
      this.pickupPlace,
      this.dropoffPoint,
      this.dropoffPlace,
      this.fromSample});
}
