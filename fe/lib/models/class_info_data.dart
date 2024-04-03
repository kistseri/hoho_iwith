import 'package:get/get.dart';  

/////////////////////////////////
//  수업정보 데이터, 컨트롤러   //
/////////////////////////////////


// 수업정보 데이터 클래스
class ClassInfoData {
  final String Stuid;
  final String Sname;
  final String gubunName;
  final String gubun;
  final String codeName;
  final String codeName2;
  final String stime;
  final String etime;
  final String DATENAME;

  
  ClassInfoData({
    required this.Stuid,
    required this.Sname,
    required this.gubunName,
    required this.gubun,
    required this.codeName,
    required this.codeName2,
    required this.stime,
    required this.etime,
    required this.DATENAME,
  });

  // JSON 데이터를 받아 BookTitleData 객체로 파싱
  factory ClassInfoData.fromJson(Map<String, dynamic> json) {
    return ClassInfoData(
      Stuid: json['Stuid'] ?? "",
      Sname: json['Sname'] ?? "",
      gubunName: json['gubunName'] ?? "",
      gubun: json['gubun'] ?? "",
      codeName: json['codeName'] ?? "",
      codeName2: json['codeName2'] ?? "",
      stime: json['stime'] ?? "",
      etime: json['etime'] ?? "",
      DATENAME: json['DATENAME'] ?? "",
    );
  }
}
// 독서클리닉 목록 데이터 컨트롤러
class ClassInfoDataController extends GetxController {
  List<ClassInfoData>? _classInfoDataList;

  void setClassInfoDataList(List<ClassInfoData> classInfoDataList) {
    _classInfoDataList = classInfoDataList;
    update();
  }
  List<ClassInfoData>? get classInfoDataList => _classInfoDataList;

  // 학생 이름 리스트
  List<String> getSnamesList(List<ClassInfoData>? classInfoDataList) {
  if (classInfoDataList == null) return []; // 예외 처리: null 체크
  return classInfoDataList.map((classInfoData) => classInfoData.Sname).toSet().toList();
  }

  // 학생 수
  int getStuNum(List<ClassInfoData>? classInfoDataList) {
  if (classInfoDataList == null) return 0; // 예외 처리: null 체크
  return classInfoDataList.map((classInfoData) => classInfoData.Sname).toSet().toList().length;
  }

  // 학생이름: 아이디를 가지는 Map
  Map<String, String> getNameId(List<ClassInfoData>? classInfoDataList) {
    Map<String, String> stuNameIdMap = {};
    if (classInfoDataList == null) return stuNameIdMap;

    for (var data in classInfoDataList) {
    String studentName = data.Sname;
    String studentId = data.Stuid; 
    
    // 이미 해당 학생 이름의 학생 아이디가 Map에 존재하는지 확인하고, 없으면 추가
    if (!stuNameIdMap.containsKey(studentName)) {
      stuNameIdMap[studentName] = studentId;
    }
  }
  return stuNameIdMap;
  }

  // 학생 이름:[수업정보]를 가지는 Map
  Map<String, List<List<String>>> getSubjectMap(List<ClassInfoData>? classInfoDataList) {
    Map<String, List<List<String>>> subjectMap = {};
    if (classInfoDataList == null) return subjectMap;
    
    for (var data in classInfoDataList) {
      String studentName = data.Sname;
      String subjectName = data.codeName;
      String subjectNumber = data.codeName2;
      String subjectSTime = data.stime;
      String subjectETime = data.etime;
      String subjectDateName = data.DATENAME;
      
      if (!subjectMap.containsKey(studentName)) {
        subjectMap[studentName] = [];
      }
      subjectMap[studentName]!.add([subjectName, subjectNumber, subjectSTime, subjectETime, subjectDateName]);
    }
    return subjectMap;
  }

}