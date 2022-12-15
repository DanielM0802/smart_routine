import 'package:flutter/material.dart';
import 'package:smart_routine/constants/colors.dart';
import 'package:smart_routine/constants/theme.dart';
import 'package:smart_routine/controllers/home_controller.dart';
import 'package:smart_routine/controllers/theme_controller.dart';
import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/providers/notification_provider.dart';
import 'package:smart_routine/views/screens/add_task_screen.dart';
import 'package:smart_routine/views/screens/all_tasks_screen.dart';
import 'package:smart_routine/views/screens/stats_screen.dart';
import 'package:smart_routine/views/widgets/bottom_sheet_button.dart';
import 'package:smart_routine/views/widgets/button.dart';
import 'package:smart_routine/views/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  final _themeController = Get.find<ThemeController>();

  late final NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    notificationProvider = NotificationProvider();
    notificationProvider.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: _appBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _showDate(),
                SizedBox(
                  height: 12.h,
                ),
                _addDateBar(),
                _homeController.myTasks.isEmpty
                    ? Expanded(
                        child: Center(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No hay hábitos para este día',
                                    style: GoogleFonts.lato(
                                      fontSize: 24.sp,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    : _showTasks(context),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () => Get.to(() => AllTasksScreen()),
                      child: Text(
                        '',
                        style: Themes().headingTextStyle,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: _addTask(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showTasks(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.only(
        top: 10.h,
      ),
      itemCount: _homeController.myTasks.length,
      itemBuilder: (_, i) {
        final data = _homeController.myTasks[i];
        final completed = _homeController.isTaskCompletedThisDate(data);
        final failed = _homeController.isTaskFailedThisDate(data);

        final DateFormat formatter = DateFormat('MM/dd/yyyy');

        if (data.repeat == 'Daily') {
          DateTime date = DateFormat.jm().parse(data.startTime!);
          DateTime dateHabit = DateFormat('MM/dd/yyyy').parse(data.date!);

          var myTime = DateFormat("HH:mm").format(date);

          if (dateHabit.isAfter(_homeController.selectedDate)) {
            return Container();
          }

          /*notificationProvider.scheduledNotification(
            task: data,
            hour: int.parse(myTime.toString().split(':')[0]),
            minutes: int.parse(
                  myTime.toString().split(':')[1],
                ) -
                data.remind!,
          );*/
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, data);
            },
            child: TaskTile(task: data, completed: completed),
          );
        }
        //manejando habitos semanales
        if (data.repeat == 'Weekly') {
          DateTime date = DateFormat.jm().parse(data.startTime!);
          if (date.weekday == _homeController.selectedDate.weekday) {
            return GestureDetector(
              onTap: () {
                _showBottomSheet(context, data);
              },
              child: TaskTile(task: data, completed: completed),
            );
          }
        }
        if (data.date ==
            DateFormat.yMd().format(_homeController.selectedDate)) {
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, data);
            },
            child: TaskTile(task: data, completed: completed),
          );
        } else {
          return Container();
        }
      },
    ));
  }

  _showBottomSheet(BuildContext context, Task task) {
    bool completed = _homeController.isTaskCompletedThisDate(task);
    bool failed = _homeController.isTaskFailedThisDate(task);
    final double height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
      Container(
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        padding: EdgeInsets.only(
          top: 8,
        ),
        height: (completed || failed) ? height * .3.h : height * .4.h,
        child: Column(
          children: [
            Container(
              height: 6.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15.r,
                ),
                color: Get.isDarkMode ? Colors.black : Colors.grey.shade300,
              ),
            ),
            Spacer(),
            (completed || failed)
                ? Text("Realizar accion")
                : Column(
                    children: [
                      BottomSheetButton(
                        label: 'Completado',
                        onTap: () {
                          _homeController.completeTask(task.id);
                          Get.back();
                          Get.snackbar(
                            'Hecho!',
                            'Hábito "${task.title}" completado!',
                            backgroundColor: Get.isDarkMode
                                ? Color(0xFF212121)
                                : Colors.grey.shade100,
                            colorText:
                                Get.isDarkMode ? Colors.white : Colors.black,
                          );
                        },
                        color: primaryColor,
                      ),
                      BottomSheetButton(
                        label: 'Omitir',
                        onTap: () {
                          _homeController.failTask(task.id);
                          final DateFormat formatter = DateFormat('MM/dd/yyyy');
                          _homeController.failTask(task.id);
                          _homeController.getTasks();
                          Get.back();
                          Get.snackbar(
                            'Tarea omitida',
                            'Tarea "${task.title}" omitida.',
                            backgroundColor: Get.isDarkMode
                                ? Color(0xFF212121)
                                : Colors.grey.shade100,
                            colorText:
                                Get.isDarkMode ? Colors.white : Colors.black,
                          );
                        },
                        color: pinkClr,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BottomSheetButton(
                        label: 'Cerrar',
                        onTap: () {
                          Get.back();
                        },
                        color: pinkClr,
                        isClosed: true,
                      )
                    ],
                  ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      toolbarHeight: 60.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            //backgroundImage: AssetImage('assets/appicon.png'),
          ),
        ],
      ),
      centerTitle: true,
      title: Text(
        'Mis hábitos',
        style: GoogleFonts.lato(
          color: _themeController.color,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            _themeController.switchTheme();
            // await notificationProvider.displayNotification(
            //   title: 'Theme Changed',
            //   body: Get.isDarkMode
            //       ? 'Activated Light Theme'
            //       : 'Activated Dark Theme',
            // );
            await Get.to(
              () => StatsScreen(),
              transition: Transition.rightToLeft,
            );
          },
          icon: Icon(Icons.auto_graph),
          color: _themeController.color,
        ),
      ],
    );
  }

  Widget _addDateBar() => SizedBox(
        child: DatePicker(
          locale: "es-es",
          DateTime.now(),
          height: 84.h,
          width: 64.w,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          onDateChange: _homeController.updateSelectedDate,
        ),
      );

  Widget _addTask() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Get.to(
                () => AddTaskScreen(),
                transition: Transition.rightToLeft,
              );
              _homeController.getTasks();
            },
            child: Text("+ Crear hábito"),
            style: ElevatedButton.styleFrom(
              backgroundColor: pinkClr,
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      );

  Widget _showDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(
                  DateTime.now(),
                ),
                style: Themes().subHeadingTextStyle,
              ),
              Text(
                'Calendario',
                style: Themes().headingTextStyle,
              ),
            ],
          ),
        ],
      );
}
