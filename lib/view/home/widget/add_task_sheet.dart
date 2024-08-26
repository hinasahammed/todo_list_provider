import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/res/components/common/custom_button.dart';
import 'package:todo_list_provider/res/components/common/custom_textformfield.dart';
import 'package:todo_list_provider/res/utils/utils.dart';
import 'package:todo_list_provider/viewmodel/home/home_viewmodel.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final homeProvider = Provider.of<HomeViewmodel>(context);
    return Consumer<HomeViewmodel>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(16),
        width: size.width,
        height: size.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add Task",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: taskController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a task name";
                  }
                  return null;
                },
                fieldName: "Task",
              ),
              const Gap(20),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  isIcon: true,
                  icon: Icons.calendar_month,
                  onPressed: () async {
                    homeProvider.selectDate(context);
                  },
                  btnText: value.selectedDate == null
                      ? "Select a date"
                      : DateFormat.yMMMEd().format(value.selectedDate!),
                ),
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  CustomButton(
                    onPressed: () {
                      if (value.selectedDate == null) {
                        Utils().showFlushToast(
                          context,
                          "Warning",
                          "Select a date",
                        );
                      } else {
                        if (_formKey.currentState!.validate()) {
                          homeProvider.addTask(taskController.text, context);
                        }
                      }
                    },
                    btnText: "Add",
                  )
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
