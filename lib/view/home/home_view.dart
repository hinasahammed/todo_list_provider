import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/viewmodel/home/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeViewmodel>(context, listen: false);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<HomeViewmodel>(
              builder: (context, value, child) {
                if (value.allTask.isEmpty || value.allTask == []) {
                  return const Center(child: Text("No task found"));
                } else {
                  return ListView.builder(
                      itemCount: value.allTask.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = value.allTask[index];
                        return Dismissible(
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.colorScheme.error,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: theme.colorScheme.onError,
                                ),
                                const Gap(20),
                                Text(
                                  "Remove",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onError,
                                  ),
                                ),
                                const Gap(20),
                                Icon(
                                  Icons.delete,
                                  color: theme.colorScheme.onError,
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            homeProvider.removeTask(value.allTask[index]);
                            return null;
                          },
                          key: ValueKey(value),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: ListTile(
                                tileColor: theme.colorScheme.primaryContainer,
                                leading: Checkbox(
                                  value: data.isCompleted,
                                  onChanged: (value) {
                                    homeProvider.updateCompleted(index);
                                  },
                                ),
                                title: Text(
                                  data.taskName,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.primary,
                                    decoration: data.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                subtitle: Text(
                                  data.date,
                                  style: theme.textTheme.labelLarge!.copyWith(
                                    color: theme.colorScheme.primary
                                        .withOpacity(.4),
                                  ),
                                ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        homeProvider.showEdit(
                                          context,
                                          index,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeProvider.openSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
