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
        padding: const EdgeInsets.only(left: 24, top: 44),
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
            Center(
              child: 
              // no tasks
              noTasksWidget(context),
            ),
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
    return Column(
              children: [
              Image.asset(
                AppAsseets.noTasks,
              ),
              Text(
                AppStrings.noTaskTitle,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20),
              ),
              Text(
                AppStrings.noTaskSubTitle,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ]);
  }
}
