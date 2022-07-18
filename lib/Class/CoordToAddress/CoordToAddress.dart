import 'AddressDoc.dart';

class CoordToAddress {
  num? total_count;
  List<AddressDoc> doc = [];

  CoordToAddress({this.total_count, required this.doc});

  factory CoordToAddress.fromJson(Map<String, dynamic> json) {
    num total_count = json["meta"]["total_count"];
    var addressDocJson = json["documents"] as List;

    List<AddressDoc> list = addressDocJson.map((e) => AddressDoc.fromJson(e)).toList();

    return CoordToAddress(total_count: total_count, doc: list);
  }
}
