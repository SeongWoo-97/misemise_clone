import 'package:misemise_clone/Class/TransCoord/Documents.dart';
import 'package:misemise_clone/Class/TransCoord/Meta.dart';

class TransCoord {
  Meta meta;
  List<Documents> documents = [];

  TransCoord({required this.meta, required this.documents});

  factory TransCoord.fromJson(Map<String, dynamic> json) {
    var metaJson = json['meta'];
    var documentJson = json['documents'] as List;

    Meta meta = Meta.fromJson(metaJson);
    List<Documents> documentList = documentJson.map((e) => Documents.fromJson(e)).toList();

    return TransCoord(
      meta: meta,
      documents: documentList,
    );
  }
}
