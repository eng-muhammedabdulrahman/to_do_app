import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';
import 'package:to_do_app/features/task/presentation/screens/add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.h),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // date now
                  Row(
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.displayLarge),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<TaskCubit>(context).changeTheme();
                          },
                          icon: Icon(
                            Icons.mode_night_sharp,
                            color: BlocProvider.of<TaskCubit>(context).isDark
                                ? AppColors.white
                                : AppColors.background,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  
                  // Today
                  Text(
                    AppStrings.toDay,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  DatePicker(
                    height: 94.h,
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: AppColors.white,
                    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  
                  // no tasks
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                              itemCount: BlocProvider.of<TaskCubit>(context)
                                  .tasksList
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(24),
                                              height: 240.h,
                                              color: AppColors.deepGrey,
                                              child: Column(children: [
                                                
                                                // Task Completed
                                                BlocProvider.of<TaskCubit>(
                                                                context)
                                                            .tasksList[index]
                                                            .isCompleted ==
                                                        1
                                                    ? Container()
                                                    : SizedBox(
                                                        height: 48.h,
                                                        width: double.infinity,
                                                        child: CustomButton(
                                                          text: AppStrings
                                                              .taskCompleted,
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        TaskCubit>(
                                                                    context)
                                                                .updateTask(BlocProvider.of<
                                                                            TaskCubit>(
                                                                        context)
                                                                    .tasksList[
                                                                        index]
                                                                    .id);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                
                                                // deleteTask
                                                SizedBox(
                                                  height: 24.h,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: AppStrings.deleteTask,
                                                    backgroundColor:
                                                        AppColors.red,
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  TaskCubit>(
                                                              context)
                                                          .deleteTask(BlocProvider
                                                                  .of<TaskCubit>(
                                                                      context)
                                                              .tasksList[index]
                                                              .id);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                
                                                // Task cancel
                                                SizedBox(
                                                  height: 24.h,
                                                ),
                                                SizedBox(
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: AppStrings.cancel,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ]),
                                            );
                                          });
                                    },
                                    child: TaskComponent(
                                      taskModel:
                                          BlocProvider.of<TaskCubit>(context)
                                              .tasksList[index],
                                    ));
                              }),
                        )
                ],
              );
            },
          ),
        ),
        // FAB floatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: const AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
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
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: 20.sp),
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
    required this.taskModel,
  });
  final TaskModel taskModel;
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

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        // height: 128.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: getColor(taskModel.color),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(children: [
          // column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  taskModel.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 8.h),
                // row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.timer_sharp,
                      color: AppColors.grey,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${taskModel.startTime} - ${taskModel.endTime}',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                // note
                Text(
                  taskModel.note,
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
                taskModel.isCompleted == 1
                    ? AppStrings.completed
                    : AppStrings.toDo,
                style: Theme.of(context).textTheme.displayMedium,
              ))
        ]),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TaskModel>('taskModel', taskModel));
  }
}
