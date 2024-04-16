import 'dart:convert';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/models/notice_data.dart';

//////////////////
//  알림 정보   //
//////////////////


// 알림 정보 가져오는 함수
Future<void> getNoticeInfo() async {

  final UserDataController userDataController = Get.put(UserDataController()); // 유저의 로그인 데이터 컨트롤러

  // 알림 정보 API URL
  String url = dotenv.get('');

  // 로그인 아이디
  String id = userDataController.userData!.id;
  // 현재 연도
  String yy = DateFormat('yyyy').format(DateTime(currentYear));
  String mm = DateFormat('MM').format(DateTime(currentYear, currentMonth));


  // HTTP POST 요청
  var response = await http.post(
    Uri.parse(url), 
    body: {
      'id': id,
      'yy': yy,
      'mm': mm,
    }
  );

  // 응답의 content-type utf-8로 인코딩으로 설정
  if (response.headers['content-type']
          ?.toLowerCase()
          .contains('charset=utf-8') != true) {
    response.headers['content-type'] = 'application/json; charset=utf-8';
  }
  try {
    // 서버로부터 응답을 성공적으로 받았을 때
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      final resultList = json.decode(response.body);
      print(resultList);

      // 응답 데이터가 성공일 때
      if (resultList[0]["result"] == null) {
        final resultList0 = resultList.cast<Map<String, dynamic>>();
         // 서버로부터 받은 JSON 데이터를 NoticeData 객체리스트로 파싱
        List<NoticeData> noticeDataList = resultList0.map<NoticeData>((json) => NoticeData.fromJson(json)).toList();
        final NoticeDataController noticeDataController = Get.put(NoticeDataController());
        noticeDataController.setNoticeDataList(noticeDataList);
      }
      // 응답 데이터가 오류일 때("9999": 오류)
      else {
        failDialog1("응답 오류", "수업정보가 없어요");
      }
    }
  }
  // 서버로부터 응답을 받지 못했을 때
  catch (e) {
    throw Exception('$e');
  }
}