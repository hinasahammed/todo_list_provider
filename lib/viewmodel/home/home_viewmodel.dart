import 'package:flutter/material.dart';
import 'package:todo_list_provider/model/task_model.dart';

class HomeViewmodel extends ChangeNotifier {
  final List<TaskModel> _allTask = [];

  List<TaskModel> get allTask => _allTask;
  
}
