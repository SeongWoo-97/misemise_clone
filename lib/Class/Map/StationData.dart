class StationData {
  String? stationName;
  String? sideName;
  String? dataTime;
  String? pm10Value; // 미세먼지
  String? pm10Grade;
  String? pm25Value; // 초미세먼지
  String? pm25Grade;
  String? no2Value; // 이산화질소
  String? no2Grade;
  String? o3Value; // 오존
  String? o3Grade;
  String? coValue; // 일산화탄소
  String? coGrade;
  String? so2Value; // 아황산가스
  String? so2Grade;
  String? khaiValue; // 통합대기환경수치
  String? khaiGrade;
  String? pm10Flag;
  String? pm25Flag;
  String? so2Flag;
  String? o3Flag;
  String? no2Flag;
  String? coFlag;

  StationData({
    this.stationName,
    this.sideName,
    this.dataTime,
    this.pm10Value,
    this.pm10Grade,
    this.pm25Value,
    this.pm25Grade,
    this.no2Value,
    this.no2Grade,
    this.o3Value,
    this.o3Grade,
    this.coValue,
    this.coGrade,
    this.so2Value,
    this.so2Grade,
    this.khaiValue,
    this.pm10Flag,
    this.pm25Flag,
    this.no2Flag,
    this.o3Flag,
    this.coFlag,
    this.so2Flag,
    this.khaiGrade,
  });

  factory StationData.fromJson(Map<String, dynamic> json) {
    return StationData(
      dataTime: json['dataTime'],
      stationName: json['stationName'],
      sideName: json['sideName'],
      pm10Value: json['pm10Value'],
      pm10Grade: json['pm10Grade'],
      pm25Value: json['pm25Value'],
      pm25Grade: json['pm25Grade'],
      no2Value: json['no2Value'],
      no2Grade: json['no2Grade'],
      o3Value: json['o3Value'],
      o3Grade: json['o3Grade'],
      coValue: json['coValue'],
      coGrade: json['coGrade'],
      so2Value: json['so2Value'],
      so2Grade: json['so2Grade'],
      khaiValue: json['khaiValue'],
      khaiGrade: json['khaiGrade'],
      pm10Flag: json['pm10Flag'],
      pm25Flag: json['pm25Flag'],
      no2Flag: json['no2Flag'],
      o3Flag: json['o3Flag'],
      coFlag: json['coFlag'],
      so2Flag: json['so2Flag'],
    );
  }
}