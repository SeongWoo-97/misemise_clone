import 'package:misemise_clone/Class/Atmosphere/AtmosData.dart';

class Atmosphere {
  num? totalCount;
  List<AtmosData> list = [];
  double? x;
  double? y;
  Atmosphere({this.totalCount, required this.list});

  factory Atmosphere.fromJson(Map<String, dynamic> json) {
    var jsonList = json['items'] as List;
    List<AtmosData> atomsList = jsonList.map((e) => AtmosData.fromJson(e)).toList();
    return Atmosphere(
      totalCount: json['totalCount'],
      list: atomsList,
    );
  }
}
