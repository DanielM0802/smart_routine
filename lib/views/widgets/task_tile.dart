import 'package:flutter/material.dart';
import 'package:smart_routine/constants/colors.dart';
import 'package:smart_routine/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      width: double.infinity.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.r),
        color: _getBackgroundClr(task.color ?? 0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title!,
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vamos a por ello',
                      style: GoogleFonts.lato(
                        fontSize: 13.sp,
                        color: Colors.grey.shade100,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey.shade200,
                      size: 18.sp,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            height: 62.h,
            width: 0.3.w,
            color: Colors.grey.shade200.withOpacity(.7),
          ),
        ],
      ),
    );
  }

  _getBackgroundClr(int no) {
    switch (no) {
      case 0:
        return primaryColor;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      case 3:
        return greenClr;

      default:
        return primaryColor;
    }
  }
}
