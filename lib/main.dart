import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/view/home/home_view.dart';
import 'package:todo_list_provider/viewmodel/home/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo with provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
