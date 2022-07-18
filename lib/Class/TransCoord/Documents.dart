class Documents {
  double x = 0.0;
  double y = 0.0;

  Documents({required this.x, required this.y});

  factory Documents.fromJson(Map<String, dynamic> parsedJson) {
    return Documents(
      x: parsedJson['x'],
      y: parsedJson['y'],
    );
  }
}
