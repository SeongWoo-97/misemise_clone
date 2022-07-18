import 'package:flutter/cupertino.dart';
import 'package:misemise_clone/Class/Atmosphere/Atmosphere.dart';
import 'package:misemise_clone/Class/CoordToAddress/CoordToAddress.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Atmosphere? _atmosphere;
  CoordToAddress? _coordToAddress;

  Atmosphere? get atmosphereData => _atmosphere;

  CoordToAddress? get coordToAddress => _coordToAddress;

  set setData(Atmosphere atmosphere) {
    _atmosphere = atmosphere;
    notifyListeners();
  }

  set setAddress(CoordToAddress coordToAddress) {
    _coordToAddress = coordToAddress;
    notifyListeners();
  }

  void refreshCurrentLocation() {
    // 스크롤시 새로고침때 사용할 메서드
  }
}
