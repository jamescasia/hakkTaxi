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
}
