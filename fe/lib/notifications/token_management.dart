import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

////////////////////////////
//  토큰 관리(발급, 전송)  //
////////////////////////////

// Fcm에서 디바이스 등록 토큰 발급
Future<void> getToken() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final token = await firebaseMessaging.getToken();
  // 토큰을 서버로 전송
  sendToken(token);
}

// 클라이언트의 등록 토큰을 서버에 전송
Future<void> sendToken(token) async {
  final loginDataController = Get.put(LoginDataController());
  final id = loginDataController.loginData!.id;
  String url = dotenv.get("TOKEN_STORAGE_URL");

  final data = {
    'id': id, 
    'token':  token, 
    'state': "Y"
  };

  try {
    var response = await http.post(
      Uri.parse(url), 
      body: data
    );
    if (response.statusCode == 200) {
      print('데이터가 성공적으로 전송되었습니다.');
    } else {
      print('데이터 전송에 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}