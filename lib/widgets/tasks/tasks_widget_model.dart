import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  Group? _group;
  Group? get group => _group;

  var _tasks = <Task>[];
  List<Task> get tasks => _tasks;

  TasksWidgetModel({required this.groupKey}) {
    _setUp();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);

    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setUp() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups');
    _loadGroup();
    _setUpListenTasks();
  }

  void _setUpListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: [groupKey]).addListener(() => _readTasks());
  }

  void deleteTask(int taskIndex) async {
    // _group?.tasks?.deleteFromHive(groupIndex);
    await _group?.tasks?.deleteFromHive(taskIndex);
    await _group?.save();
  }

  void showTaskForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/tasks/form', arguments: groupKey);
    // , arguments: groupKey
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  TasksWidgetModelProvider({required super.child, required this.model})
      : super(notifier: model);

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }
}
