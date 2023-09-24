import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // get Date From User
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      print('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      print('pickedStartTime == null');
      emit(GetStartTimeErrorState());
    }
  }

  void geEndtTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      print('pickedStartTime == null');
      emit(GetEndTimeErrorState());
    }
  }

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

  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
//! insert tasks
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(TaskModel(
        title: titleController.text,
        note: noteController.text,
        startTime: startTime,
        endTime: endTime,
        date: DateFormat.yMd().format(currentDate),
        isCompleted: 0,
        color: currentIndex,
      ));
      getTasks();
      //! to make screen wait 3 second
      // await Future.delayed(const Duration(seconds: 3));
      // tasksList.add(
      //   TaskModel(
      //     id: '1',
      //     title: titleController.text,
      //     note: noteController.text,
      //     startTime: startTime,
      //     endTime: endTime,
      //     data: DateFormat.yMd().format(currentDate),
      //     isCompleted: false,
      //     color: currentIndex,
      //   ),
      // );
      titleController.clear();
      noteController.clear();

      emit(InsertTaskSuccessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//! get tasks
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
              (element) => element.date == DateFormat.yMd().format(selectedDate))
          .toList();
      emit(GetDateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

//! update Task
  void updateTask(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updateDB(id).then((value) {
      emit(UpdateTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

//! delete task
  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }
}
