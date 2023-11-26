import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_bar/app_bar_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';
import 'package:todo_app/widgets/task_form/task_form_widget_model.dart';
import 'package:todo_app/widgets/tasks/tasks_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_model?.groupKey);
    return TaskFormWidgetProvider(
        child: const _TaskFormWidgetBody(), model: _model!);
    // print(widget?.groupKey);
    // return _TaskFormWidgetBody();
    // return TaskFormWidgetProvider(
    //     model: model!, child: const _TaskFormWidgetBody());
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({
    super.key,
  });
  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _create(BuildContext context, TextEditingController controller) {
    if (_isValid(controller.text)) {
      TaskFormWidgetProvider.read(context)?.model.saveTask(context);
      print(controller.text);
      // print(TaskFormWidgetProvider.read(context)?.model.)
    }
  }

  bool _isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: MyAppBar(
        title: 'Создать задачу',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Что надо сделать'),
          autofocus: true,
          controller: controller,
          onChanged: (value) =>
              TaskFormWidgetProvider.read(context)?.model.taskText = value,
          onEditingComplete: () =>
              TaskFormWidgetProvider.read(context)?.model.saveTask(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _create(context, controller),
          child: const Icon(Icons.done)),
    );

    //     AlertDialog(
    //   title: const Text('Создать задачу'),
    //   content: TextField(
    //     autofocus: true,
    //     controller: controller,
    //     onChanged: (value) =>
    //         TaskFormWidgetProvider.read(context)?.model.taskText = value,
    //   ),
    //   actions: [
    //     TextButton(onPressed: () => _cancel(context), child: Text('Cancel')),
    //     TextButton(
    //         onPressed: () => _create(context, controller), child: Text('OK'))
    //   ],
    // );
  }
}
