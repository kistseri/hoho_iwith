import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';

import '../../style.dart';

///////////////////////
// 학생 수업정보 박스 //
///////////////////////

Widget studentInfoBox(name) {
  final screenSize = MediaQuery.of(Get.context!).size;

  // 컨트롤러
  final loginDataController = Get.put(LoginDataController());
  final classInfoDataController = Get.put(ClassInfoDataController());

  // 이름:[수업정보]를 가지는 map
  final nameSubjectMap = classInfoDataController
      .getSubjectMap(classInfoDataController.classInfoDataList);
  // 수업정보 리스트(과목명, 과목호수, 시작시간, 종료시간, 요일)
  final subjectList = nameSubjectMap[name] ?? [];
  // 현재 월
  final currentMonth = getCurrentMonth();

  final monthValue = classInfoDataController
      .getLastYMMap(classInfoDataController.classInfoDataList);

  String lastMonth = monthValue[name]!.substring(4);
  if (lastMonth.startsWith("0")) {
    lastMonth = lastMonth.substring(1);
  }

  return Container(
    padding: const EdgeInsets.only(left: 30),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(Get.context!).colorScheme.onSecondaryContainer,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 센터 이름
                Text(loginDataController.loginData!.cname,
                    style: const TextStyle(
                        color: CommonColors.grey1,
                        fontSize: 16,
                        fontFamily: "NotoSansKR-SemiBold")),
                const SizedBox(height: 5),
                // 학생 이름
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: name,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const TextSpan(text: " 학생", style: TextStyle(fontSize: 25)),
                  ]),
                ),
              ],
            ),
            // 월
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text("$lastMonth월",
                    style:
                        const TextStyle(color: LightColors.blue, fontSize: 20)),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        // 수강정보
        Container(
          margin: const EdgeInsets.only(left: 5),
          width: screenSize.width * 0.7,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: subjectList.length,
              itemBuilder: (context, index) {
                final subjectName = subjectList[index][0];
                final subjectNum = subjectList[index][1];
                final formattedStartTime =
                    "${subjectList[index][2].substring(0, 2)}:${subjectList[index][2].substring(2)}";
                final formattedEndTime =
                    "${subjectList[index][3].substring(0, 2)}:${subjectList[index][3].substring(2)}";
                final dateName = subjectList[index][4];
                final gubunName = subjectList[index][5];

                return gubunName == "서당"
                    ? Text(
                        "한스쿨 - $subjectName$subjectNum ($dateName $formattedStartTime~$formattedEndTime)",
                        style: const TextStyle(color: CommonColors.grey1))
                    : Text(
                        "북스쿨 - $subjectName$subjectNum ($dateName $formattedStartTime~$formattedEndTime)",
                        style: const TextStyle(color: CommonColors.grey1));
              }),
        )
      ],
    ),
  );
}
