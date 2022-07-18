import 'dart:collection';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:misemise_clone/Class/Atmosphere/Atmosphere.dart';
import 'package:misemise_clone/Class/CoordToAddress/CoordToAddress.dart';
import 'package:misemise_clone/Class/CurrentLocationProvider.dart';
import 'package:misemise_clone/Class/Map/StationCoord.dart';
import 'package:misemise_clone/Class/Map/StationData.dart';
import 'package:misemise_clone/Class/Map/StationOnMap.dart';
import 'package:misemise_clone/Screen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Class/NearStation/Station.dart';
import '../Class/StationOnMapProvider.dart';
import '../Class/TransCoord/TransCoord.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loadingState = "Loading...";
  late StationOnMapProvider stationOnMapProvider = Provider.of<StationOnMapProvider>(context,listen: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      netWorkCheck();
      Position currentLocation = await currentLocationPermissionCheck(); // init 에 넣을까?
      await getCurrentLocationData(currentLocation.longitude, currentLocation.latitude);
      await getTotalStationCoord();
      // 권한요청
      // GPS 정보를 바탕으로 값을 가져오는 함수 생성
      // Hive 불러오기 [즐겨찾기, box.put('favoriteList',['측정소명1','측정소명2','측정소명3']); GPS 제외 즐겨찾기 최대6개
      // API 요청
      // 홈 화면 이동
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1DE9B6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 180, bottom: 50),
                  child: Image.asset(
                    'assets/splash/cloud.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      loadingState,
                      textStyle: TextStyle(color: Colors.white),
                      duration: Duration(milliseconds: 1700),
                    ),
                  ],
                  totalRepeatCount: 25,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'MiseMise',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 네트워크 연결여부
  netWorkCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        loadingState = "네트워크 오류";
      });
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text('네트워크 오류')),
              buttonPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/icon/maintenance.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '미세미세는 인터넷에 연결이 되어있어야만 사용이 가능합니다. 네트워크 상태를 확인해주세요.\n',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          text: '\n만약 네트워크 연결이 되어있는데 안된다면 메일을 보내주세요~\n',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          text: '\n* 1분 뒤에도 안된다면',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xffF57C00)),
                        ),
                        TextSpan(
                          text: ' [ 여기 ]',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xff0505FF)),
                        ),
                        TextSpan(
                          text: '를 클릭 하신 후 허용을 해주세요 그 후 핸드폰을 껏다 켜주세요!*',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xffF57C00)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        color: Colors.grey[200],
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              '이메일 보내기',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: Color(0xFFF57C00),
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              '1분 후 해볼게~',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
              actionsPadding: EdgeInsets.zero,
            );
          });
    }
    return Container();
  }

  Future<Position> currentLocationPermissionCheck() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 미세미세 어플은 현재위치를 거부하면 "등록된 즐겨찾기" 화면에서 직접 동네를 지정할 수 있도록 되어있다.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    ;
  }

  Future<void> getCurrentLocationData(double x, double y) async {
    String dataGoKrServiceKey =
        "35X01gApVcjR%2BikKAOumjSYoRY58GexIZzjwaMH%2B%2BckhZ7PkXP93ED92U7mLOD3l21Y3IGsFsQghRBxsBFhngA%3D%3D";
    String atomsServiceKey = "35X01gApVcjR%2BikKAOumjSYoRY58GexIZzjwaMH%2B%2BckhZ7PkXP93ED92U7mLOD3l21Y3IGsFsQghRBxsBFhngA%3D%3D";
    CurrentLocationProvider locationProvider = Provider.of<CurrentLocationProvider>(context, listen: false);

    // 좌표계 변환 API 요청
    http.Response response = await http.get(
        Uri.parse('https://dapi.kakao.com/v2/local/geo/transcoord.json?input_coord=WGS84&output_coord=TM&x=$x&y=$y'),
        headers: {"Authorization": "KakaoAK 74ee892061bb366d616f636f4d4adf38"});
    Map<String, dynamic> json = jsonDecode(response.body);
    TransCoord transCoord = TransCoord.fromJson(json);

    double tmX = transCoord.documents[0].x;
    double tmY = transCoord.documents[0].y;
    // 근처측정소 API 요청
    http.Response dataGoKrResponse = await http.get(Uri.parse(
        'http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList?tmX=$tmX&tmY=$tmY&returnType=json&serviceKey=$dataGoKrServiceKey'));
    Map<String, dynamic> dataJson = jsonDecode(dataGoKrResponse.body);
    Station station = Station.fromJson(dataJson["response"]["body"]);

    String? stationName = station.TMCoords![0].stationName;

    // 가장 가까운 거리의 측정소 데이터 API 요청
    http.Response atomsResponse = await http.get(Uri.parse(
        'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=$stationName&dataTerm=daily&pageNo=1&numOfRows=100&returnType=json&ver=1.3&serviceKey=$atomsServiceKey'));
    Map<String, dynamic> atmosJson = jsonDecode(atomsResponse.body);
    Atmosphere atmosphere = Atmosphere.fromJson(atmosJson["response"]["body"]);

    locationProvider.setData = atmosphere;

    http.Response addressResponse = await http.get(
        Uri.parse("https://dapi.kakao.com/v2/local/geo/coord2address.json?input_coord=WGS84&x=129.3746705&y=36.0631854"),
        headers: {"Authorization": "KakaoAK 74ee892061bb366d616f636f4d4adf38"});

    Map<String, dynamic> addressJson = jsonDecode(addressResponse.body);
    print('$x');
    print('$y');
    print(addressJson);
    CoordToAddress coordToAddress = CoordToAddress.fromJson(addressJson);

    locationProvider.setAddress = coordToAddress;
  }

  Future<void> getTotalStationCoord() async {
    String serviceKey = "35X01gApVcjR%2BikKAOumjSYoRY58GexIZzjwaMH%2B%2BckhZ7PkXP93ED92U7mLOD3l21Y3IGsFsQghRBxsBFhngA%3D%3D";
    http.Response response = await http.get(Uri.parse(
        'http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getMsrstnList?addr=&stationName=&pageNo=1&numOfRows=1000&serviceKey=$serviceKey&returnType=json'));

    Map<String, dynamic> responseCoordJson = jsonDecode(response.body);
    var jsonList = responseCoordJson["response"]["body"]["items"] as List;
    List<StationCoord> stationList = jsonList.map((e) => StationCoord.fromJson(e)).toList();
    Map<String, StationOnMap> stationOnMap = {};

    stationList.forEach((element) {
      stationOnMap['${element.stationName}'] = StationOnMap(stationCoord: element);
    });

    http.Response responseAtoms = await http.get(Uri.parse(
        'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?sidoName=전국&pageNo=1&numOfRows=1000&returnType=json&serviceKey=$serviceKey&ver=1.0'));
    Map<String, dynamic> responseAtomsJson = jsonDecode(responseAtoms.body);
    var responseList = responseAtomsJson["response"]["body"]["items"] as List;
    List<StationData> atomsJsonList = responseList.map((e) => StationData.fromJson(e)).toList();

    atomsJsonList.forEach((element) {
      if (stationOnMap.containsKey('${element.stationName}')) {
        stationOnMap["${element.stationName}"] = StationOnMap(stationCoord: stationOnMap['${element.stationName}']?.stationCoord,stationData: element);
      }
    });
    // Provider 에 불러온 데이터 저장
    stationOnMapProvider.setData = stationOnMap;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
  }
}
