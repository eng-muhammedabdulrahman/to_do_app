// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/presentation/components/add_task_component.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  DateTime currentDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Title
                AddTaskComponent(
                  controller: titleController,
                  title: AppStrings.title,
                  hintText: AppStrings.titleHint,
                ),
                //! Note
                 SizedBox(height: 24.h),
                AddTaskComponent(
                  controller: noteController,
                  title: AppStrings.note,
                  hintText: AppStrings.noteHint,
                ),
                //! Date
                 SizedBox(height: 24.h),
                AddTaskComponent(
                  title: AppStrings.date,
                  hintText: DateFormat.yMd().format(currentDate),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      setState(() {
                        if (pickedDate != null) {
                          currentDate = pickedDate;
                        } else {
                          print('pickedDate == null');
                        }
                      });
                    },
                    icon: const Icon(Icons.calendar_month_rounded),
                    color: AppColors.white,
                  ),
                  readOnly: true,
                ),
                 SizedBox(height: 24.h),
                //! Start - End Time
                Row(
                  children: [
                    // Start
                    Expanded(
                      child: AddTaskComponent(
                        readOnly: true,
                        title: AppStrings.startTime,
                        hintText: startTime,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? pickedStartTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                DateTime.now(),
                              ),
                            );
                            if (pickedStartTime != null) {
                              setState(
                                () {
                                  startTime = pickedStartTime.format(context);
                                },
                              );
                            } else {
                              print('pickedStartTime == null');
                            }
                          },
                          icon: const Icon(Icons.timer_outlined),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 27),
                    // End
                    Expanded(
                      child: AddTaskComponent(
                        readOnly: true,
                        title: AppStrings.endTime,
                        hintText: endTime,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? pickedEndTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                DateTime.now(),
                              ),
                            );
                            if (pickedEndTime != null) {
                              setState(
                                () {
                                  endTime = pickedEndTime.format(context);
                                },
                              );
                            } else {
                              print('pickedEndTime == null');
                            }
                          },
                          icon: const Icon(Icons.timer_outlined),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 24.h),
                //! Color
                SizedBox(
                  height: 68.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.color,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                       SizedBox(height: 8.h),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          separatorBuilder: (context, index) =>  SizedBox(
                            width: 8.w,
                          ),
                          itemBuilder: (context, index) {
                            Color getColor(index) {
                              switch (index) {
                                case 0:
                                  return AppColors.red;
                                case 1:
                                  return AppColors.green;
                                case 2:
                                  return AppColors.blueGrey;
                                case 3:
                                  return AppColors.blue;
                                case 4:
                                  return AppColors.orange;
                                case 5:
                                  return AppColors.purple;
                                default:
                                  return AppColors.grey;
                              }
                            }
            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: getColor(index),
                                child: index == currentIndex
                                    ? const Icon(Icons.check)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      // const Row(
                      //   children: [
                      //     CircleAvatar(
                      //       backgroundColor: AppColors.red,
                      //     ),
                      //     CircleAvatar(
                      //       backgroundColor: AppColors.red,
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
                //! add Task Button
                 SizedBox(height: 92.h),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: CustomButton(
                    text: AppStrings.createTask,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
