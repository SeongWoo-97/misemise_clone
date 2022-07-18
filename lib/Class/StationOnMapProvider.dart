import 'package:flutter/cupertino.dart';
import 'package:misemise_clone/Class/Map/StationOnMap.dart';

class StationOnMapProvider extends ChangeNotifier {
  Map<String,StationOnMap> _stationOnMap = {};

  Map<String, StationOnMap> get stationOnMap => _stationOnMap;

  set setData(Map<String,StationOnMap> map) {
    _stationOnMap = map;
    notifyListeners();
  }
}