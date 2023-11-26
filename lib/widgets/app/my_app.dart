import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget.dart';
import 'package:todo_app/widgets/task_form/task_form_widget.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent)),
      title: 'TODO',
      routes: {
        '/groups': (context) => GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/tasks': (context) => const TasksWidget(),
        '/groups/tasks/form': (context) => const TaskFormWidget(),
      },
      initialRoute: '/groups',
    );
  }
}
