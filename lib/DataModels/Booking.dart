import 'package:latlong/latlong.dart';

class Booking {
  LatLng pickupPoint;
  String pickupPlace = "";
  LatLng dropoffPoint;
  String dropoffPlace = "";
  Duration tripDuration = Duration(seconds: 0);
  double distance = 0.0;
  bool fromSample = false;
  DateTime day = DateTime.now();

  Duration realDuration = Duration(seconds: 0);
  Booking(
      {this.pickupPoint,
      this.pickupPlace,
      this.dropoffPoint,
      this.dropoffPlace,
      this.fromSample});
}
