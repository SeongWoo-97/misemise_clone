class Address {
  String? addressName;
  String? regionOneName;
  String? regionTwoName;
  String? regionThreeName;
  String? mountain;
  String? mainAddress;
  String? subAddress;
  String? zipCode;

  Address(
      {this.addressName,
      this.regionTwoName,
      this.regionThreeName,
      this.regionOneName,
      this.mainAddress,
      this.mountain,
      this.subAddress,
      this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressName: json['address_name'],
      regionOneName: json['region_1depth_name'],
      regionTwoName: json['region_2depth_name'],
      regionThreeName: json['region_3depth_name'],
      mountain: json['mountain_yn'],
      mainAddress: json['main_address_no'],
      subAddress: json['sub_address_no'],
      zipCode: json['zip_code'],
    );
  }
}
