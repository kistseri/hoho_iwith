import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data/report_weekly_data.dart';
import 'package:flutter_application/screens/book/school_report/school_monthly_result.dart';
import 'package:flutter_application/screens/book/school_report/school_weekly_result.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/widgets/date_format.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

////////////
// 한스쿨 //
///////////

class HanReport extends StatefulWidget {
  HanReport({super.key, required this.year, required this.month}): pageDate = formatYMKorean(year, month);

  final int year;
  final int month;
  final String pageDate;

  @override
  State<HanReport> createState() => _HanReportState();
}

class _HanReportState extends State<HanReport> {
  final dropdownButtonController = Get.put(DropdownButtonController());
  final reportWeeklyDataController = Get.put(ReportWeeklyDataController());
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final isValidBook = reportWeeklyDataController.sBookName != "" ? true : false;
    
    return Obx(() => Container(
      color: themeController.isLightTheme.value 
        ? Color(int.parse(reportWeeklyDataController.sWeeklyDataList[0].color, radix: 16))
        : DarkColors.basic,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 한스쿨 이미지
          titleImage("book_report_han.png"),
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
            text: isValidBook
            ? TextSpan(
              children: [
                colorText(
                  reportWeeklyDataController.sBookName, 
                  themeController.isLightTheme.value ? LightColors.blue : DarkColors.blue),
                normalText("를 학습했어요."),
              ])
            : normalText("학습 데이터가 없어요."),
          ),
          // 주차별 내용
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final week = index + 1;
                final isValidData = week <= reportWeeklyDataController.sWeeklyDataList.length ? true : false;

                return SchoolWeeklyResult(
                  week: week,
                  isValidData: isValidData,
                  children: isValidData
                    ? [
                      subTitleImage("han_report1.png", "신습한자/학습어휘", const Color(0xff868ad6)),
                      Text(reportWeeklyDataController.sWeeklyDataList[week - 1].weekNote1),
                      const SizedBox(height: 5),
                      subTitleImage("han_report2.png", "수업지도", const Color(0xff34b8bc)),
                      Text(reportWeeklyDataController.sWeeklyDataList[week - 1].weekNote2),
                      const SizedBox(height: 5),
                      subTitleImage("han_report3.png", "TEST", const Color(0xfff1a63a)),
                      LinearPercentIndicator(
                        width: 220,
                        lineHeight: 15,
                        percent: reportWeeklyDataController.sWeeklyDataList[week - 1].score / 6,
                        backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
                        progressColor: const Color(0xfff6cf35),
                        barRadius: const Radius.circular(10),
                        animation: true,
                        animationDuration: 1000,
                      ),
                      const SizedBox(height: 20),
                    ]
                    : [],
                );
              },
            ),
          ),
          // 최종 평가
           schoolMonthlyResult("han"),
        ],
      ),
    ));
  }
}