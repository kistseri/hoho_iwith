import 'dart:convert';
import 'package:flutter_application/models/book_data/first_book_read_date_data.dart';
import 'package:flutter_application/utils/network_check.dart';
import 'package:flutter_application/utils/get_dropdown_stuId.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

////////////////////////////
//  독클 시작 날짜 데이터  //
////////////////////////////

// 독클 시작 날짜 독서 데이터 가져오는 함수
Future<void> getFirstBookReadDateData() async {

  // 컨트롤러
  final ConnectivityController connectivityController = Get.put(ConnectivityController());
  final StudentIdController studentIdController = Get.put(StudentIdController()); 

  if (connectivityController.isConnected.value) {  
    
    String url = dotenv.get('BOOK_READ_FIRST_DATE_URL');
    
    // 학생 아이디
    final stuId = studentIdController.getStuId();

    // HTTP POST 요청
    var response = await http.post(
      Uri.parse(url), 
      body: {
        'stuid': stuId, 
      }
    );

    // 응답의 content-type utf-8로 인코딩으로 설정
    if (response.headers['content-type']?.toLowerCase().contains('charset=utf-8') != true) {
      response.headers['content-type'] = 'application/json; charset=utf-8';
    }
    try {
      // 응답을 성공적으로 받았을 때
      if (response.statusCode == 200) {
        final resultList = json.decode(response.body);

        // 응답 데이터가 성공일 때
        if (resultList[0]["result"] == null) {
          BookReadDateData bookReadDateData = BookReadDateData.fromJson(resultList[0]);                          
          final BookReadDateDataController bookReadDateDataController = Get.put(BookReadDateDataController());     
          bookReadDateDataController.setBookReadDateData(bookReadDateData);
        }
        // 응답 데이터가 오류일 때("9999": 오류)
        else {
          failDialog1("응답 오류", "독클 결과가 없어요");
        }
      }
    }
    // 응답을 받지 못했을 때
    catch (e) {
      null;
    }
  } else {
    failDialog1("연결 실패", "인터넷 연결을 확인해주세요");
  }
}