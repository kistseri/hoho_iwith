import 'package:flutter/material.dart';
import 'package:flutter_application/screens/book/school_monthly_result.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/widgets/dashed_divider.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/imagebox_decoration.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

///////////
///한스쿨//
//////////
class HanReport extends StatefulWidget {
  final int year;
  final int month;
  final String pageDate;

  HanReport({super.key, required this.year, required this.month}) : pageDate = DateFormat('yyyy년 M월').format(DateTime(year, month));

  @override
  State<HanReport> createState() => _HanReportState();
}

class _HanReportState extends State<HanReport> {
  final dropdownButtonController = Get.put(DropdownButtonController()); 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffaeef4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 한스쿨 이미지
          Container(
            height: 80,
            width: 80,
            decoration: imageBoxDecoration(
              'assets/images/book/book_report_han.png', BoxFit.contain),
          ),
          // 텍스트
          Obx(() => RichText(
            text: TextSpan(
            children: [
              normalText("${dropdownButtonController.currentItem.value} 학생은 "),
              normalText(widget.pageDate),
              normalText("에"),
            ]),
          )),
          RichText(
            text: TextSpan(children: [
              colorText("박사 1호", LightColors.blue),
              normalText("를 학습했어요."),
            ]),
          ),
          // 주차별 내용
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return weeklyHanResult(index + 1);
              },
            ),
          ),
          // 텍스트
          RichText(text: normalText("월간 학습 성취도 평가 결과에서")),
          RichText(
            text: TextSpan(children: [
              colorText("표현력", const Color(0xffed4282)),
              normalText("이 매우 뛰어났어요."),
            ]),
          ),
          // 최종 평가
          monthlyReportResult("han"),
        ],
      ),
    );
  }
}

// 주차별 내용
Widget weeklyHanResult(week) {
  return Stack(
    children: [
      Row(
        children: [
          // 주차
          Expanded(
            flex: 2,
            child: Center(
              child: Text( "$week주차", style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CommonColors.grey4),
            )),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 학습 어휘
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(5),
                        decoration: imageBoxDecoration(
                          "assets/images/book/han_report1.png", BoxFit.contain),
                      ),
                      const Text("학습 어휘",  style: TextStyle(
                        color: Color(0xff868ad6),
                        fontFamily: "NotoSansKR-SemiBold"),
                      )
                    ],
                  ),
                  const Text("한자 한자 한자 한자"),
                  const SizedBox(height: 10),
                  // 수업 지도
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(5),
                        decoration: imageBoxDecoration(
                          "assets/images/book/han_report2.png", BoxFit.contain),
                      ),
                      const Text("수업지도", style: TextStyle(
                        color: Color(0xff34b8bc),
                        fontFamily: "NotoSansKR-SemiBold"),
                      )
                    ],
                  ),
                  const Text("1번 ㅇㅇㅇㅇㅇㅇ"),
                  const SizedBox( height: 10),
                  // 점수
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(5),
                        decoration: imageBoxDecoration(
                          "assets/images/book/han_report3.png", BoxFit.contain),
                      ),
                      const Text("TEST", style: TextStyle(
                        color: Color(0xfff1a63a),
                        fontFamily: "NotoSansKR-SemiBold"),
                      )
                    ],
                  ),
                  LinearPercentIndicator(
                    width: 220,
                    lineHeight: 15,
                    percent: 0.5,
                    backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
                    progressColor: const Color(0xfff6cf35),
                    barRadius: const Radius.circular(10),
                    animation: true,
                    animationDuration: 1000,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
      // 수직 구분선
      Positioned(
        top: 0,
        bottom: 0,
        left: MediaQuery.of(Get.context!).size.width / 5, // 구분선이 시작되는 위치 조정
        child: const DashedVerticalDivider(),
      ),
    ],
  );
}
