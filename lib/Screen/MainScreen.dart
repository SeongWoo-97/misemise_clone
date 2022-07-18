import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:misemise_clone/Screen/MapScreen.dart';
import 'package:provider/provider.dart';

import '../Class/CurrentLocationProvider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
  late CurrentLocationProvider data = Provider.of<CurrentLocationProvider>(context, listen: false);
  late Color backgroundColor;
  late Color insideColor;
  late int dustStepIcon;
  late String status;
  late String statusMsg;
  double index = 0.0;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.0608923071516, 129.38002726495608),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
    int pm10Value = int.parse('${data.atmosphereData!.list[0].pm10Value}');
    if (pm10Value >= 0 && pm10Value <= 15) {
      backgroundColor = Colors.blue[700]!;
      insideColor = Colors.blue[600]!;
      dustStepIcon = 1;
      status = "최고 좋음";
      statusMsg = "신선한 공기 많이 마시세요~";
    } else if (pm10Value >= 16 && pm10Value <= 30) {
      backgroundColor = Colors.lightBlue[700]!;
      insideColor = Colors.lightBlue[600]!;
      dustStepIcon = 2;
      status = "좋음";
      statusMsg = "신선한 공기 많이 마시세요~";
    } else if (pm10Value >= 31 && pm10Value <= 40) {
      backgroundColor = Colors.cyan[700]!;
      insideColor = Colors.cyan[600]!;
      dustStepIcon = 3;
      status = "양호";
      statusMsg = "쾌적한 날이에요~";
    } else if (pm10Value >= 41 && pm10Value <= 50) {
      backgroundColor = Colors.green[700]!;
      insideColor = Colors.green[600]!;
      dustStepIcon = 4;
      status = "보통";
      statusMsg = "그냥 무난한 날이에요~";
    } else if (pm10Value >= 51 && pm10Value <= 75) {
      backgroundColor = Colors.orange[900]!;
      insideColor = Colors.orange[800]!;
      dustStepIcon = 5;
      status = "나쁨";
      statusMsg = "공기가 탁하네요. 조심하세요~";
    } else if (pm10Value >= 76 && pm10Value <= 100) {
      backgroundColor = Colors.deepOrange[800]!;
      insideColor = Colors.deepOrange[700]!;
      dustStepIcon = 6;
      status = "상당히 나쁨";
      statusMsg = "탁한 공기, 마스크 챙기세요~";
    } else if (pm10Value >= 101 && pm10Value <= 150) {
      backgroundColor = Colors.red[800]!;
      insideColor = Colors.red[700]!;
      dustStepIcon = 7;
      status = "매우 나쁨";
      statusMsg = "위험합니다! 외출을 삼가세요!";
    } else {
      backgroundColor = Colors.grey[900]!;
      insideColor = Colors.grey[800]!;
      dustStepIcon = 8;
      status = "최악";
      statusMsg = "절대 나가지 마세요!!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.map_outlined),
              color: Colors.white,
              iconSize: 26,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      drawer: Container(
        width: 280,
        child: Drawer(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xFF1DE9B6),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/splash/cloud.png',
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '미세미세',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Ver 1.0.0',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    drawerListTile(Icon(Icons.favorite, color: Colors.red), '아끼는 사람에게 알려주기'),
                    drawerListTile(
                        Icon(
                          Icons.bar_chart,
                          color: Colors.greenAccent,
                        ),
                        '미세먼지 세계보건기구(WHO) 기준'),
                    drawerListTile(
                        Icon(
                          Icons.looks_6,
                          color: Colors.green,
                        ),
                        '미세먼지 8단계 모드'),
                    drawerListTile(Icon(Icons.drafts), '불편/개선 사항 보내기'),
                    drawerListTile(Icon(Icons.info), '미세먼지 정보'),
                    drawerListTile(Icon(Icons.image), '예보 이미지'),
                    drawerListTile(
                        Icon(
                          Icons.alarm,
                          color: Colors.redAccent,
                        ),
                        '미세먼지 알람/경보'),
                    drawerListTile(
                        Icon(
                          Icons.bookmark,
                          color: Colors.cyan,
                        ),
                        '광고 제거'),
                    drawerListTile(
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        '설정 (위치 삭제,위젯)'),
                    drawerListTile(
                        Icon(
                          Icons.cloud,
                          color: Colors.lightBlue,
                        ),
                        "'날씨날씨'앱 다운받기"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LocationNameText(),
              updateTime(),
              dustStepIconAndText(),
              dotPageViewIndicator(),
              Card(
                margin: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                color: insideColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Container(
                        height: 122,
                        color: insideColor,
                        child: CarouselSliderWidget(),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              forecastByHour(),
              forecastByDay(),
              NearByStation(),
              Details(),
            ],
          ),
        ),
      ),
    );
  }

  Widget AppBarButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            iconSize: 27,
            onPressed: () => Drawer(
              child: Text('하이'),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.map_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget LocationNameText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 5),
      child: Column(
        children: [
          Text(
            '(현재 위치)',
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            '${data.coordToAddress!.doc[0].address.regionTwoName} ${data.coordToAddress!.doc[0].address.regionThreeName}',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget updateTime() {
    return Text(
      '$formattedDate',
      style: TextStyle(fontSize: 24, color: Colors.white),
    );
  }

  Widget dustStepIconAndText() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Image.asset(
            'assets/dustStep/$dustStepIcon.png',
            color: Colors.white,
            width: 170,
            height: 170,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                status,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  statusMsg,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dotPageViewIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: InkWell(
        onTap: () {
          setState(() {
            if (index == 6.0) {
              index = 0.0;
            } else {
              index += 1.0;
            }
          });
        },
        child: DotsIndicator(
          decorator: DotsDecorator(
            color: backgroundColor,
            activeColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            spacing: EdgeInsets.only(right: 3),
            size: Size(7.0, 7.0),
            activeSize: Size(7.0, 7.0),
          ),
          dotsCount: 7,
          position: index,
        ),
      ),
    );
  }

  Widget pm10Widget() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '미세먼지',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/2.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Text(
          '${data.atmosphereData!.list[0].pm10Value} ㎍/㎥',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget pm25Widget() {
    int pm25Value = int.parse('${data.atmosphereData!.list[0].pm25Value}');
    late int index;
    String status;
    if (pm25Value >= 0 && pm25Value <= 8) {
      index = 1;
      status = statusToEnum("step1");
    } else if (pm25Value >= 9 && pm25Value <= 15) {
      index = 2;
      status = statusToEnum("step2");
    } else if (pm25Value >= 16 && pm25Value <= 20) {
      index = 3;
      status = statusToEnum("step3");
    } else if (pm25Value >= 21 && pm25Value <= 25) {
      index = 4;
      status = statusToEnum("step4");
    } else if (pm25Value >= 26 && pm25Value <= 37) {
      index = 5;
      status = statusToEnum("step5");
    } else if (pm25Value >= 38 && pm25Value <= 50) {
      index = 6;
      status = statusToEnum("step6");
    } else if (pm25Value >= 51 && pm25Value <= 75) {
      index = 7;
      status = statusToEnum("step7");
    } else {
      index = 8;
      status = statusToEnum("step8");
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '초미세먼지',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/$index.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Text(
          '${data.atmosphereData!.list[0].pm25Value} ㎍/㎥',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget no2Widget() {
    num no2Value = num.parse('${data.atmosphereData!.list[0].no2Value}');
    late int index;
    String status;
    if (no2Value >= 0 && no2Value <= 0.02) {
      index = 1;
      status = statusToEnum("step1");
    } else if (no2Value > 0.02 && no2Value <= 0.03) {
      index = 2;
      status = statusToEnum("step2");
    } else if (no2Value > 0.03 && no2Value <= 0.05) {
      index = 3;
      status = statusToEnum("step3");
    } else if (no2Value > 0.05 && no2Value <= 0.06) {
      index = 4;
      status = statusToEnum("step4");
    } else if (no2Value > 0.06 && no2Value <= 0.13) {
      index = 5;
      status = statusToEnum("step5");
    } else if (no2Value > 0.13 && no2Value <= 0.2) {
      index = 6;
      status = statusToEnum("step6");
    } else if (no2Value > 0.2 && no2Value <= 1.1) {
      index = 7;
      status = statusToEnum("step7");
    } else {
      index = 8;
      status = statusToEnum("step8");
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '이산화질소',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/$index.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '${data.atmosphereData!.list[0].no2Value} ppm',
            style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget o3Widget() {
    num o3Value = num.parse('${data.atmosphereData!.list[0].o3Value}');
    late int index;
    String status;
    if (o3Value >= 0 && o3Value <= 0.02) {
      index = 1;
      status = statusToEnum("step1");
    } else if (o3Value > 0.02 && o3Value <= 0.03) {
      index = 2;
      status = statusToEnum("step2");
    } else if (o3Value > 0.03 && o3Value <= 0.06) {
      index = 3;
      status = statusToEnum("step3");
    } else if (o3Value > 0.06 && o3Value <= 0.09) {
      index = 4;
      status = statusToEnum("step4");
    } else if (o3Value > 0.09 && o3Value <= 0.12) {
      index = 5;
      status = statusToEnum("step5");
    } else if (o3Value > 0.12 && o3Value <= 0.15) {
      index = 6;
      status = statusToEnum("step6");
    } else if (o3Value > 0.15 && o3Value <= 0.38) {
      index = 7;
      status = statusToEnum("step7");
    } else {
      index = 8;
      status = statusToEnum("step8");
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '오존',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/$index.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '${data.atmosphereData!.list[0].o3Value} ppm',
            style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget coWidget() {
    num coValue = num.parse('${data.atmosphereData!.list[0].coValue}');
    late int index;
    String status;
    if (coValue >= 0 && coValue <= 1) {
      index = 1;
      status = statusToEnum("step1");
    } else if (coValue > 1 && coValue <= 2) {
      index = 2;
      status = statusToEnum("step2");
    } else if (coValue > 2 && coValue <= 5.5) {
      index = 3;
      status = statusToEnum("step3");
    } else if (coValue > 5.5 && coValue <= 9) {
      index = 4;
      status = statusToEnum("step4");
    } else if (coValue > 9 && coValue <= 12) {
      index = 5;
      status = statusToEnum("step5");
    } else if (coValue > 12 && coValue <= 15) {
      index = 6;
      status = statusToEnum("step6");
    } else if (coValue > 15 && coValue <= 32) {
      index = 7;
      status = statusToEnum("step7");
    } else {
      index = 8;
      status = statusToEnum("step8");
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '일산화탄소',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/$index.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '${data.atmosphereData!.list[0].coValue} ppm',
            style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget so2Widget() {
    num so2Value = num.parse('${data.atmosphereData!.list[0].so2Value}');
    late int index;
    String status;
    if (so2Value >= 0 && so2Value <= 0.01) {
      index = 1;
      status = statusToEnum("step1");
    } else if (so2Value > 0.01 && so2Value <= 0.02) {
      index = 2;
      status = statusToEnum("step2");
    } else if (so2Value > 0.02 && so2Value <= 0.04) {
      index = 3;
      status = statusToEnum("step3");
    } else if (so2Value > 0.04 && so2Value <= 0.05) {
      index = 4;
      status = statusToEnum("step4");
    } else if (so2Value > 0.05 && so2Value <= 0.1) {
      index = 5;
      status = statusToEnum("step5");
    } else if (so2Value > 0.1 && so2Value <= 0.15) {
      index = 6;
      status = statusToEnum("step6");
    } else if (so2Value > 0.15 && so2Value <= 0.6) {
      index = 7;
      status = statusToEnum("step7");
    } else {
      index = 8;
      status = statusToEnum("step8");
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '아황산가스',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/dustStep/$index.png',
            color: Colors.white,
            width: 35,
            height: 35,
          ),
        ),
        Text(
          '$status',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '${data.atmosphereData!.list[0].so2Value} ppm',
            style: TextStyle(color: Colors.white).copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget CarouselSliderWidget() {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1.0,
      ),
      items: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              pm10Widget(),
              pm25Widget(),
              no2Widget(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              o3Widget(),
              coWidget(),
              so2Widget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget forecastByHour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
          child: Text(
            '시간별 예보',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Card(
          color: insideColor,
          margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: Container(
            width: 500,
            height: 100,
            child: ListView.builder(
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          '오후 ${index + 1}시',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Image.asset(
                        'assets/dustStep/3.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          '좋음',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget forecastByDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
          child: Text(
            '일별 예보',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Card(
          color: insideColor,
          margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: Container(
              width: 500,
              height: 430,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('수요일 아침', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/1.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('좋음', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('수요일 점심', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/2.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('좋음', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('수요일 저녁', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/3.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('목요일 아침', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/4.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('목요일 점심', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/2.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('목요일 저녁', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/3.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('금요일 아침', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/1.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('금요일 점심', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/4.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('금요일 저녁', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/1.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('좋음', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('토요일 아침', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/4.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('보통', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('토요일 점심', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/5.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('나쁨', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('토요일 저녁', style: TextStyle(color: Colors.white, fontSize: 15)),
                        Image.asset(
                          'assets/dustStep/1.png',
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text('좋음', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }

  Widget NearByStation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
          child: Text(
            '주변 측정소 정보',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Card(
          color: insideColor,
          margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: Container(
            width: 500,
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  rotateGesturesEnabled: false, // 회전 여부
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget Details() {
    double fontSize = 14;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
          child: Text(
            '세부사항',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Card(
          color: insideColor,
          margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '업데이트 시간: 2022-02-24 11:00',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: fontSize),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 107),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'PM10 측정소 이름: 장량동\n', style: TextStyle(height: 1.5)),
                            TextSpan(text: 'PM2.5 측정소 이름: 장량동\n', style: TextStyle(height: 1.5)),
                            TextSpan(text: 'NO2 측정소 이름: 장량동\n', style: TextStyle(height: 1.5)),
                            TextSpan(text: 'O3 측정소 이름: 장량동\n', style: TextStyle(height: 1.5)),
                            TextSpan(text: 'CO 측정소 이름: 장량동\n', style: TextStyle(height: 1.5)),
                            TextSpan(text: 'SO2 측정소 이름: 장량동', style: TextStyle(height: 1.5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: 'pm10 측정망 분류: 도시대기\n', style: TextStyle(height: 1.5)),
                              TextSpan(text: 'pm2.5 측정소 분류: 도시대기', style: TextStyle(height: 1.5)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: '통합지수 값: 58 unit (최근24시간 평균)\n', style: TextStyle(height: 1.5)),
                              TextSpan(text: '통합지수 상태: 보통 (최근24시간 평균)', style: TextStyle(height: 1.5)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.3,
                  color: Colors.white,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '미세미세는 사용자분과 가장 가까이 위치한, 정상 작동 중인 측정소의 \n실시간 정보를 보여드립니다.\n\n',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                    TextSpan(
                      text: '본 자료는 한국환경공단(에어코리아)과 기상청에서 제공하는 실시간 관측\n자료이며 실제 대기농도 수치와 다를 수 있습니다.\n',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  String statusToEnum(String step) {
    switch (step) {
      case "step1":
        return "최고 좋음";
      case "step2":
        return "좋음";
      case "step3":
        return "양호";
      case "step4":
        return "보통";
      case "step5":
        return "나쁨";
      case "step6":
        return "상당히 나쁨";
      case "step7":
        return "매우 나쁨";
      case "step8":
        return "최악";
      case "stepNull":
        return "장비점검";
      default:
        return "Null";
    }
  }

  Widget drawerListTile(Icon icon, String msg) {
    return ListTile(
      leading: icon,
      title: Text(
        '$msg',
        style: TextStyle(color: Colors.black),
      ),
      horizontalTitleGap: 5,
    );
  }
}
