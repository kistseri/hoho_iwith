import 'package:get/get.dart';

////////////////////////
//  월말 레포트 보이기   //
////////////////////////

// 데이터 클래스
class ReportViewData {
  final String reportVisible; // 독서 권수

  ReportViewData({
    required this.reportVisible,
  });

  factory ReportViewData.fromJson(Map<String, dynamic> json) {
    return ReportViewData(
      reportVisible: json['view_yn'] ?? "",
    );
  }
}

// 데이터 컨트롤러
class ReportViewDataController extends GetxController {
  ReportViewData? _reportViewData;

  void setReportViewData(ReportViewData reportViewData) {
    _reportViewData = reportViewData;
    update();
  }

  ReportViewData? get reportViewData => _reportViewData;
}
