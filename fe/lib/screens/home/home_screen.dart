import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/screens/home/home_menu_box.dart';
import 'package:flutter_application/screens/home/home_student_info_box.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/app_bar_drawer.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:get/get.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';

///////////////////
//    홈 화면    //
///////////////////

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 컨트롤러
  final ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController()); // 수업 정보 
  final readNotiController = Get.put(ReadNotiController());   // 푸시 알림 확인 여부
  final themeController = Get.put(ThemeController());

  // 푸시 알림 확인 여부 로드
  Future<void> _loadisReadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    readNotiController.isRead.value = prefs.getBool('isRead') ?? false; 
  }

  // 수업정보 박스
  List<Widget> _buildBanners(BuildContext context, List<String> snamesList) {
    return snamesList.map((name) => studentInfoBox(context, name)).toList();
  }
  Widget bannerCarousel(BuildContext context, List<String> snamesList) {
    final banners = _buildBanners(context, snamesList);
    final Size screenSize = MediaQuery.of(context).size;

    return BannerCarousel(
      customizedIndicators: const IndicatorModel.animation(width: 10, height: 5, spaceBetween: 2, widthAnimation: 30),
      activeColor: Colors.white70,
      disableColor: Colors.white38,
      animation: true,
      width: screenSize.width * 0.9,
      height: screenSize.width * 0.45,
      indicatorBottom: false,
      customizedBanners: banners,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadisReadInfo();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // 형제자매 이름 리스트
    List<String> snamesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);

    return Obx(
      () => Container(
        // 홈 배경화면
        decoration: 
          // 라이트/다크 모드 배경이미지
          themeController.isLightTheme.value
          ? imageBoxDecoration('assets/images/background.jpg', BoxFit.cover)
          : imageBoxDecoration('assets/images/dark_background.jpg', BoxFit.cover),
        // 홈 Content
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: homeAppBar(screenSize),
          // 앱 바의 사이드 메뉴
          endDrawer: appbarDrawer(context),
          // 바디
          body: Center(
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.1),
                // 학생 정보 박스(이름, 센터, 수강정보)
                bannerCarousel(context, snamesList),
                const SizedBox(height: 30),
                // 메뉴 박스(출석체크, 학원비 납부, 알림장, 독클결과)
                menuBox(screenSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}