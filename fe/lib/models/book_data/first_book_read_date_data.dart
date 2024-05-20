import 'package:get/get.dart';  

////////////////////////
// 연간독서량 데이터  //
///////////////////////

// 데이터 클래스
class BookReadDateData {
  final String startYear;
  final String startMonth;

  BookReadDateData({
    required this.startYear,
    required this.startMonth,
  });

  factory BookReadDateData.fromJson(Map<String, dynamic> json) {
    return BookReadDateData(
      startYear: json['startYear'] ?? "",
      startMonth: json['startMonth'] ?? "",
    );
  }
}

// 데이터 컨트롤러
class BookReadDateDataController extends GetxController {
  BookReadDateData? _bookReadDateData;           

  void setBookReadDateData(BookReadDateData bookReadDateData) {
    _bookReadDateData = bookReadDateData;
    update();
  }
  BookReadDateData? get bookReadDateData => _bookReadDateData;
}