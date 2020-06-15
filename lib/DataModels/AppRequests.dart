import 'dart:convert';

import 'package:grabApp/DataModels/AuthKeys.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

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
}
