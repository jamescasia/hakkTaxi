import 'dart:convert';

import 'package:grabApp/DataModels/AuthKeys.dart';
import 'package:grabApp/DataModels/Booking.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math' as math;

class AppRequests {
  static getAddressFromLatLng(LatLng latlng) async {
    return (json.decode((await http.get(
            'https://atlas.microsoft.com/search/address/reverse/json?api-version=1.0&query=${latlng.latitude}%2C${latlng.longitude}&subscription-key=${AuthKeys.mapsAuthKey}'))
        .body));

    // print(json.decode(res));

    // return;
  }

  static getPathBetweenPoints(LatLng orig, LatLng des) async {
    return (json.decode((await http.get(
            'https://atlas.microsoft.com/route/directions/json?subscription-key=${AuthKeys.mapsAuthKey}&api-version=1.0&query=${orig.latitude}%2C${orig.longitude}%3A${des.latitude}%2C${des.longitude}'))
        .body));
  }

  static getETA(Booking booking) async {
    await Future.delayed(Duration(milliseconds: 500));

    // await http
    //     .post(
    //         'http://8109fcb0-b370-4467-b0c2-6d0d4bc1f6c2.eastus.azurecontainer.io/score',
    //         headers: {HttpHeaders.contentTypeHeader: "application/json"},
    //         body: json.encode({
    //           "data": [
    //             {
    //               "pickup_day": 1,
    //               "pickup_hour": 1,
    //               "pingtimestamp": 1,
    //               "rawlat_dropoff": 1,
    //               "rawlat_pickup": 1,
    //               "rawlng_dropoff": 1,
    //               "rawlng_pickup": 1233,
    //             }
    //           ]
    //         }))
    //     .then((response) {
    //   print("Response status: ${response.statusCode}");
    //   print("Response body: ${response.body}");
    // }).catchError((err) {
    //   print(err);
    // });

    var res = (await http.post(
            'http://4f0a7c4d-8805-4057-a963-fae4639ece1d.eastus.azurecontainer.io/score',
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
            body: json.encode({
              "data": [
                {
                  "day_of_week": booking.dayOfWeek,
                  "hour_of_day": booking.hourOfDay,
                  "timestamp": booking.pingtimestamp,
                  "latitude_destination": booking.dropoffPoint.latitude,
                  "latitude_origin": booking.pickupPoint.latitude,
                  "longitude_destination": booking.dropoffPoint.longitude,
                  "longitude_origin": booking.pickupPoint.longitude,
                }
              ]
            })))
        .body;

    return (jsonDecode(res)[0]).toInt();
  }
}
