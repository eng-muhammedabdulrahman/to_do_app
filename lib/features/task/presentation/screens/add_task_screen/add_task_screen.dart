import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          child: Column(
            children: [
              //! Title
              AddTaskComponent(
                controller: titleController,
                title: AppStrings.title,
                hintText: AppStrings.titleHint,
              ),
              //! Note
              const SizedBox(height: 24),
              AddTaskComponent(
                controller: noteController,
                title: AppStrings.note,
                hintText: AppStrings.noteHint,
              ),
              //! Date
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              //! Start - End Time
              Row(
                children: [
                  // Start
                  Expanded(
                    child: AddTaskComponent(
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
                      title: AppStrings.endTime,
                      hintText: endTime,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
