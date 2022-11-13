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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
                height: 35.h,
                width: 346.w,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                      color: pinkClr,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
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
            _rampageDays(),
            SizedBox(
              height: 25.h,
            ),
            _currentRampage(),
            SizedBox(
              height: 25.h,
            ),
            _recordStats()
          ],
        ),
      ),
    );
  }

  _recordStats() {
    return Row(
      children: [
        SizedBox(
          height: 155.h,
          width: ((346 - 40) / 2).w,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
              )),
        ),
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          height: 155.h,
          width: ((346 - 40) / 2).w,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
              )),
        )
      ],
    );
  }

  _currentRampage() {
    return SizedBox(
      height: 105.h,
      width: 346.w,
      child: DecoratedBox(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tu racha actual",
                          style: Themes().subHeadingTextStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                          "El número consecutivo de los días en los que completaste todos tus hábitos",
                          style: Themes().subTitleStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("3 Dias", style: Themes().subTitleStyle)
                    ],
                  ),
                ),
                const Icon(
                  Icons.flash_on,
                  color: pinkClr,
                  size: 24.0,
                ),
              ],
            ),
          )),
    );
  }

  _rampageDays() {
    return SizedBox(
      height: 105.h,
      width: 346.w,
      child: DecoratedBox(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total de días magníficos",
                          style: Themes().subHeadingTextStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                          "El número total de días en los que completaste todos tus habitos",
                          style: Themes().subTitleStyle),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("3 Dias", style: Themes().subTitleStyle)
                    ],
                  ),
                ),
                const Icon(
                  Icons.calendar_month,
                  color: pinkClr,
                  size: 24.0,
                ),
              ],
            ),
          )),
    );
  }

  _appBar() {
    return AppBar(
      toolbarHeight: 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
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
