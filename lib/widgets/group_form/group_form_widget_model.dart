import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/group.dart';

class GroupFormWidgetModel {
  var groupName = '';
  saveGroup(BuildContext context) async {
    if (groupName.isEmpty) {
      return;
    }
    Navigator.pop(context);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups');
    final group = Group(name: groupName);
    unawaited(box.add(group));
    print(box.values);
  }
}

class GroupFormWidgetProvider extends InheritedWidget {
  final GroupFormWidgetModel model;

  GroupFormWidgetProvider({required super.child, required this.model});

  static GroupFormWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetProvider>()
        ?.widget;
    return widget is GroupFormWidgetProvider ? widget : null;
  }

  static GroupFormWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
