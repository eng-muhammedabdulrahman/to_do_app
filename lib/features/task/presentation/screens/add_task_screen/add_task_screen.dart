// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/presentation/components/add_task_component.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSuccessState) {
                showToast(
                    message: 'Added Successfully', state: ToastStates.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<TaskCubit>(context);
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Title
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).titleController,
                      title: AppStrings.title,
                      hintText: AppStrings.titleHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.titleErrorMsg;
                        }
                        return null;
                      },
                    ),
                    //! Note
                    SizedBox(height: 24.h),
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                      title: AppStrings.note,
                      hintText: AppStrings.noteHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.noteErrorMsg;
                        }
                        return null;
                      },
                    ),
                    //! Date
                    SizedBox(height: 24.h),
                    AddTaskComponent(
                      title: AppStrings.date,
                      hintText: DateFormat.yMd().format(cubit.currentDate),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          cubit.getDate(context);
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
                            hintText: cubit.startTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                cubit.getStartTime(context);
                              },
                              icon: const Icon(Icons.timer_outlined),
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 27.w),
                        // End
                        Expanded(
                          child: AddTaskComponent(
                            readOnly: true,
                            title: AppStrings.endTime,
                            hintText: cubit.endTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                cubit.geEndtTime(context);
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
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8.w,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    cubit.changeCheckMarkIndex(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: cubit.getColor(index),
                                    child: index == cubit.currentIndex
                                        ? const Icon(Icons.check)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //! add Task Button
                    SizedBox(height: 92.h),
                    state is InsertTaskLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary))
                        : SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: CustomButton(
                              text: AppStrings.createTask,
                              onPressed: () {
                                if (BlocProvider.of<TaskCubit>(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  BlocProvider.of<TaskCubit>(context)
                                      .insertTask();
                                }
                              },
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
