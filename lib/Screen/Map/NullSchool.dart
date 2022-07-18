import 'package:flutter/material.dart';

class NullSchool extends StatefulWidget {
  const NullSchool({Key? key}) : super(key: key);

  @override
  _NullSchoolState createState() => _NullSchoolState();
}

class _NullSchoolState extends State<NullSchool> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('널스쿨 페이지'),
    );
  }
}
