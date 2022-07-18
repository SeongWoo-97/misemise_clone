class Meta {
  int total_count;

  Meta({required this.total_count});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(
      total_count: parsedJson['total_count'],
    );
  }
}
