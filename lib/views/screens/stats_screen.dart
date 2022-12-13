import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_routine/constants/colors.dart';

import '../../constants/theme.dart';
import '../../controllers/theme_controller.dart';

class StatsScreen extends StatefulWidget {
  StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final _themeController = Get.find<ThemeController>();
  final double _padding = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - _padding * 2;
    return Scaffold(
      appBar: _appBar(width),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            FittedBox(
                fit: BoxFit.fill,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: pinkClr,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 2, vertical: 10),
                      child: const Text(
                        "Hábitos",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 25.h,
            ),
            _rampageDays(width),
            SizedBox(
              height: 25.h,
            ),
            _currentRampage(width),
            SizedBox(
              height: 25.h,
            ),
            _recordStats(width)
          ],
        ),
      ),
    );
  }

  _recordStats(double width) {
    const double middleSpace = 40;
    const double height = 150;
    return Row(
      children: [
        SizedBox(
          width: (width - middleSpace) / 2,
          height: height,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.auto_graph,
                      color: pinkClr,
                      size: 60.0,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("5 Dias", style: Themes().subHeadingTextStyle),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("Mejor racha", style: Themes().subTitleStyle)
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: middleSpace,
        ),
        SizedBox(
          width: (width - middleSpace) / 2,
          height: height,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.checklist,
                        color: pinkClr,
                        size: 60.0,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("17", style: Themes().subHeadingTextStyle),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("Total de hábitos", style: Themes().subTitleStyle),
                      Text("completados", style: Themes().subTitleStyle)
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }

  _currentRampage(double width) {
    return SizedBox(
      width: width,
      child: DecoratedBox(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tu racha actual",
                          style: Themes().subHeadingTextStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("El número consecutivo de los días",
                          style: Themes().subTitleStyle),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("en los que completaste todos tus hábitos",
                          style: Themes().subTitleStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("3 Dias", style: Themes().subTitleStyle)
                    ],
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  const Icon(
                    Icons.flash_on,
                    color: pinkClr,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _rampageDays(double width) {
    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total de días magníficos",
                        style: Themes().subHeadingTextStyle),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("El número total de días en los",
                        style: Themes().subTitleStyle),
                    Text("que completaste todos tus habitos",
                        style: Themes().subTitleStyle),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("3 Dias", style: Themes().subTitleStyle)
                  ],
                ),
                SizedBox(
                  width: 40.w,
                ),
                const Icon(
                  Icons.calendar_month,
                  color: pinkClr,
                  size: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _appBar(double width) {
    return AppBar(
      toolbarHeight: 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: _themeController.color,
        ),
      ),
      centerTitle: true,
      title: Text(
        'Estadisticas',
        style: GoogleFonts.lato(
          color: _themeController.color,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
