class TMCoord {
  num? tm;
  String? address;
  String? stationName;

  TMCoord({this.tm,this.address,this.stationName});

  factory TMCoord.fromJson(Map<String,dynamic> json) {
    return TMCoord(
      tm: json['tm'],
      address: json['addr'],
      stationName: json['stationName'],
    );
  }
}