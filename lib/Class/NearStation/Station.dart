import 'package:misemise_clone/Class/NearStation/TmCoord.dart';

class Station {
  num? totalCount;
  List<TMCoord>? TMCoords = [];
  num? pageNo;
  num? numOfRows;

  Station({this.totalCount, this.TMCoords, this.pageNo, this.numOfRows});

  factory Station.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;

    List<TMCoord> aList = list.map((e) => TMCoord.fromJson(e)).toList();

    return Station(
      totalCount: json['totalCount'],
      TMCoords: aList,
      pageNo: json['pageNo'],
      numOfRows: json['numOfRows'],
    );
  }
}
