import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_routine/constants/colors.dart';
import 'package:smart_routine/constants/theme.dart';
import 'package:smart_routine/controllers/add_task_controller.dart';
import 'package:smart_routine/controllers/theme_controller.dart';
import 'package:smart_routine/models/task.dart';
import 'package:smart_routine/views/widgets/button.dart';
import 'package:smart_routine/views/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final AddTaskController _addTaskController = Get.put(AddTaskController());

  final ThemeController _themeController = Get.find();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  final List<int> reminderList = [
    5,
    10,
    15,
    20,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                hint: 'Hacer ejercicio...',
                title: 'Nombre',
                controller: _titleController,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      hint: '30',
                      title: '¿Cuántos minutos?',
                      controller: _titleController,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: InputField(
                      hint: 'Minutos',
                      title: '',
                      widget: SizedBox(
                        width: 50.w,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                            //customItemsHeight: 8.h,
                            items: [
                              ...repeatList.map(
                                (item) => DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (val) => _addTaskController
                                .updateSelectedRepeat(val.toString()),
                            itemHeight: 30.h,
                            dropdownPadding: EdgeInsets.all(
                              8,
                            ),
                            dropdownWidth: 110.w,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                            ),
                            dropdownElevation: 1,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: Column(
                  //quitar el margin entre rows
                  children: [
                    Row(children: [
                      Expanded(
                          child: Button(
                              label: 'Diariamente',
                              onTap: (() => _validateTask()))),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Button(
                              label: 'Semanalmente',
                              onTap: (() => _validateTask()))),
                    ]),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(children: [
                      Expanded(
                          child: Button(
                              label: 'Mensualmente',
                              onTap: (() => _validateTask()))),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Button(
                              label: 'Una vez',
                              onTap: (() => _validateTask()))),
                    ]),
                  ],
                ),
              ),
              InputField(
                hint: DateFormat.yMd().format(_addTaskController.selectedDate),
                title: 'Date',
                widget: IconButton(
                  onPressed: () => _getDateFromUser(context),
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      hint: _addTaskController.selectedStartTime,
                      title: 'Start Date',
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(context, true),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: InputField(
                      hint: _addTaskController.selectedEndTime,
                      title: 'End Date',
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(context, false),
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              InputField(
                hint: '${_addTaskController.selectedReminder} minutes early',
                title: 'Reminder',
                widget: SizedBox(
                  width: 50.w,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      customButton: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                      ),
                      //customItemsIndexes: reminderList,
                      //customItemsHeights: [8],
                      items: [
                        ...reminderList.map(
                          (item) => DropdownMenuItem<String>(
                            value: item.toString(),
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (val) => _addTaskController
                          .updateSelectedReminder(int.parse(val.toString())),
                      itemHeight: 30.h,
                      dropdownPadding: EdgeInsets.all(
                        8,
                      ),
                      dropdownWidth: 80.w,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      dropdownElevation: 1,
                    ),
                  ),
                ),
              ),
              InputField(
                hint: _addTaskController.selectedRepeat,
                title: 'Repeat',
                widget: SizedBox(
                  width: 50.w,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      customButton: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                      ),
                      //customItemsHeight: 8.h,
                      items: [
                        ...repeatList.map(
                          (item) => DropdownMenuItem<String>(
                            value: item.toString(),
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (val) => _addTaskController
                          .updateSelectedRepeat(val.toString()),
                      itemHeight: 30.h,
                      dropdownPadding: EdgeInsets.all(
                        8,
                      ),
                      dropdownWidth: 110.w,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      dropdownElevation: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  Button(label: 'Create Task', onTap: () => _validateTask())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateTask() async {
    if (_titleController.text.isNotEmpty || _noteController.text.isNotEmpty) {
      Task task = Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(
          _addTaskController.selectedDate,
        ),
        startTime: _addTaskController.selectedStartTime,
        endTime: _addTaskController.selectedEndTime,
        remind: _addTaskController.selectedReminder,
        color: _addTaskController.selectedColorIndex,
        repeat: _addTaskController.selectedRepeat,
        isCompleted: 0,
      );
      //await _addTaskController.addTaskToDB(task);
      Get.back();
    } else {
      Get.snackbar(
        'Required',
        'All fields are required',
        backgroundColor:
            Get.isDarkMode ? Color(0xFF212121) : Colors.grey.shade100,
        colorText: pinkClr,
      );
    }
  }

  Widget _colorPallete() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: Themes().titleStyle,
          ),
          SizedBox(
            height: 3.h,
          ),
          Wrap(
            children: List<Widget>.generate(
              4,
              (i) => Padding(
                padding: EdgeInsets.only(
                  right: 6,
                ),
                child: GestureDetector(
                  onTap: () => _addTaskController.updateSelectedColorIndex(i),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: i == 0
                          ? primaryColor
                          : i == 1
                              ? pinkClr
                              : i == 2
                                  ? yellowClr
                                  : greenClr,
                      child: _addTaskController.selectedColorIndex == i
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 18.sp,
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );

  _appBar() {
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
      title: Text(
        'Nuevo Hábito',
        style: GoogleFonts.lato(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: _themeController.color),
      ),
    );
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2012),
        initialDate: DateTime.now(),
        lastDate: DateTime(2122));

    if (pickerDate != null) {
      _addTaskController.updateSelectedDate(pickerDate);
    }
  }

  _getTimeFromUser(BuildContext context, bool isStartTime) async {
    String? formatedTime;
    await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
      ),
    ).then((value) => formatedTime = value!.format(context));

    if (isStartTime) {
      _addTaskController.updateSelectedStartTime(formatedTime!);
    } else {
      _addTaskController.updateSelectedEndTime(formatedTime!);
    }
  }
}
