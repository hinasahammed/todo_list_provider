import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_provider/model/task_model.dart';
import 'package:todo_list_provider/res/utils/utils.dart';
import 'package:todo_list_provider/view/home/widget/add_task_sheet.dart';
import 'package:todo_list_provider/view/home/widget/edit_task_viewmodel.dart';

class HomeViewmodel extends ChangeNotifier {
  final List<TaskModel> _allTask = [];
  DateTime? _selectedDate;

  List<TaskModel> get allTask => _allTask;
  DateTime? get selectedDate => _selectedDate;

  void openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const AddTaskSheet(),
    );
  }

  void selectDate(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (selectDate == null) {
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", "Select a date");
      }
    } else {
      _selectedDate = selectDate;
    }
    notifyListeners();
  }

  void addTask(String taskName, BuildContext context) {
    _allTask.add(
      TaskModel(
        taskName: taskName,
        date: DateFormat.yMMMEd().format(_selectedDate!),
      ),
    );
    Navigator.pop(context);
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    _allTask.remove(task);
    notifyListeners();
  }

  void updateCompleted(int index) {
    _allTask[index].isCompleted = !allTask[index].isCompleted;
    notifyListeners();
  }

  void editTaskNAme(int index, String newTask,BuildContext context) {
    _allTask[index].taskName = newTask;
    notifyListeners();
    Navigator.pop(context);
  }

  void showEdit(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: EditTaskDialogue(
              index: index,
            ),
          );
        });
  }
}
