import 'package:misemise_clone/Class/CoordToAddress/Address.dart';
import 'package:misemise_clone/Class/CoordToAddress/RoadAddress.dart';

class AddressDoc {
  RoadAddress roadAddress;
  Address address;

  AddressDoc({required this.address, required this.roadAddress});

  factory AddressDoc.fromJson(Map<String, dynamic> json) {
    var a = json['road_address'];
    var b = json['address'];

    RoadAddress listA = RoadAddress.fromJson(a);
    Address listB = Address.fromJson(b);
    return AddressDoc(
      roadAddress: listA,
      address: listB,
    );
  }
}
