import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';
  TaskFormWidgetModel({
    required this.groupKey,
  });

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) {
      print('empty');
      return;
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final tasksBox = await Hive.openBox<Task>('tasks');
    final task = Task(text: taskText, isDone: false);
    tasksBox.add(task);
    print('tasks: ${tasksBox.values}');

    final groupsBox = await Hive.openBox<Group>('groups');
    final group = groupsBox.get(groupKey);
    group?.addTask(tasksBox, task);
    print('group`s tasks: ${group?.tasks}');
    print('group`s key: ${groupKey}');
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetProvider extends InheritedWidget {
  final TaskFormWidgetModel model;
  TaskFormWidgetProvider({required super.child, required this.model});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static TaskFormWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetProvider>()
        ?.widget;
    return widget is TaskFormWidgetProvider ? widget : null;
  }

  static TaskFormWidgetProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetProvider>();
  }

  // @override
  // bool updateShouldNotifyDependent(
  //     covariant InheritedModel oldWidget, Set dependencies) {
  //   // TODO: implement updateShouldNotifyDependent
  //   throw UnimplementedError();
  // }
}
