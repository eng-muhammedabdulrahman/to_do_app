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
              // Title
              AddTaskComponent(
                controller: titleController,
                title: AppStrings.title,
                hintText: AppStrings.titleHint,
              ),
              // Note
              const SizedBox(height: 24),
              AddTaskComponent(
                controller: noteController,
                title: AppStrings.note,
                hintText: AppStrings.noteHint,
              ),
              // Date
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
                      currentDate = pickedDate!;
                    });
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                  color: AppColors.white,
                ),
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
