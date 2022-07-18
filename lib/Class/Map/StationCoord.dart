class StationCoord {
  String? stationName;
  String? address;
  String? dmX;
  String? dmY;
  String? mangName; //도시대기, 교외대기, 도로변대기, 항만 기타등등

  StationCoord({this.stationName, this.address, this.dmX, this.dmY, this.mangName});
  factory StationCoord.fromJson(Map<String,dynamic> json) {
    return StationCoord(
      stationName: json["stationName"],
      address: json["addr"],
      dmX: json["dmX"],
      dmY: json["dmY"],
      mangName: json["mangName"],
    );
  }
}
