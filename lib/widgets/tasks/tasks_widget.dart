import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_bar/app_bar_widget.dart';
import 'package:todo_app/widgets/task_form/task_form_widget.dart';
import 'package:todo_app/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    print('tasks widget model: ${model?.tasks}');
    if (model != null) {
      return TasksWidgetModelProvider(child: TasksWidgetBody(), model: model);
    } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final groupName = model?.group?.name ?? 'Список дел';
    print(model?.tasks);
    return Scaffold(
      appBar: MyAppBar(title: groupName),
      body: const _TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showTaskForm(context),
        // GroupsWidgetModelProvider.read(context)?.model.showFrom(context),
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) => TaskFormWidget(
        //           groupKey: model?.groupKey,
        //         )),
        tooltip: 'Добавить задачу',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final tasksCount = model?.tasks.length ?? 0;
    print('model`s tasks: ${model?.tasks}');
    print('model`s group key: ${model?.groupKey}');
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) => _TaskRowWidget(
              idxTaskList: index,
            ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: tasksCount);
  }
}

class _TaskRowWidget extends StatelessWidget {
  final int idxTaskList;
  const _TaskRowWidget({super.key, required this.idxTaskList});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[idxTaskList].text;
    return ListTile(
      title: Text(task),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
