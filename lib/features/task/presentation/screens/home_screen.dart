import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // date now
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            // Today
            Text(
              AppStrings.toDay,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 14,
            ),
            DatePicker(
              height: 94,
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColors.selectDate,
              selectedTextColor: AppColors.white,
              dateTextStyle: Theme.of(context).textTheme.displayMedium!,
              dayTextStyle: Theme.of(context).textTheme.displayMedium!,
              monthTextStyle: Theme.of(context).textTheme.displayMedium!,
              onDateChange: (date) {
                // New date selected
                //   setState(() {
                //     _selectedValue = date;
                //   });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            // Center(
            //   child:
            //   // no tasks
            //   // noTasksWidget(context),
            // ),
            const TaskComponent(),
            const TaskComponent(),
          ],
        ),
      ),
      // FAB floatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(children: [
      Image.asset(
        AppAsseets.noTasks,
      ),
      Text(
        AppStrings.noTaskTitle,
        style:
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
      ),
      Text(
        AppStrings.noTaskSubTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    ]);
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(children: [
        // column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text
              Text(
                'Task 1',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              // row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.timer_sharp,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '09:33 PM - 09:48 PM',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
              const SizedBox(height: 8),
              // text
              Text(
                'Learn Dart',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
        // divider
        const VerticalDivider(
          color: AppColors.line,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        // text
        RotatedBox(
            quarterTurns: 3,
            child: Text(
              AppStrings.toDo,
              style: Theme.of(context).textTheme.displayMedium,
            ))
      ]),
    );
  }
}
