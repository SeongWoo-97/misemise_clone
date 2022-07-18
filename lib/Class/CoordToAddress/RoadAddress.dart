class RoadAddress {
  String? addressName;
  String? regionOneName;
  String? regionTwoName;
  String? regionThreeName;
  String? roadName;
  String? underground;
  String? mainBuildingNum;
  String? subBuildingNum;
  String? buildingName;
  String? zoneNum;

  RoadAddress({
    this.addressName,
    this.mainBuildingNum,
    this.regionOneName,
    this.regionThreeName,
    this.regionTwoName,
    this.roadName,
    this.subBuildingNum,
    this.underground,
    this.zoneNum,
    this.buildingName,
  });

  factory RoadAddress.fromJson(Map<String, dynamic> json) {
    return RoadAddress(
      addressName: json['address_name'],
      regionOneName: json['region_1depth_name'],
      regionTwoName: json['region_2depth_name'],
      regionThreeName: json['region_3depth_name'],
      roadName: json['road_name'],
      underground: json['underground_yn'],
      mainBuildingNum: json['main_building_no'],
      subBuildingNum: json['sub_building_no'],
      buildingName: json['building_name'],
      zoneNum: json['zone_no'],
    );
  }
}
