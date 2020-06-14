import 'package:latlong/latlong.dart';

class Booking {
  LatLng pickupPoint;
  String pickupPlace;
  LatLng dropoffPoint;
  String dropoffPlace;
  double tripDuration;
  bool fromSample = false;

  Booking(
      {this.pickupPoint,
      this.pickupPlace,
      this.dropoffPoint,
      this.dropoffPlace,
      this.tripDuration,
      this.fromSample});
}
