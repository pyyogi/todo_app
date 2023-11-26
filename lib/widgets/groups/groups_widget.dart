import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/app_bar/app_bar_widget.dart';
import 'package:todo_app/widgets/group_form/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(model: _model, child: _GroupsBodyWidget());
  }
}

class _GroupsBodyWidget extends StatelessWidget {
  _GroupsBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Группы'),
      body: const Column(
        children: [
          Expanded(
            child: _GroupsListWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            // GroupsWidgetModelProvider.read(context)?.model.showFrom(context),
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GroupFormWidget();
                }),
        tooltip: 'Добавить группу',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupsListWidget extends StatelessWidget {
  const _GroupsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _GroupsListRowWidget(
            idxList: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 3,
            ),
        itemCount: groupsCount);
  }
}

class _GroupsListRowWidget extends StatelessWidget {
  final int idxList;
  const _GroupsListRowWidget({super.key, required this.idxList});

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[idxList];

    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: (context) => model.deleteGroup(idxList),
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
        SlidableAction(
          onPressed: (context) => () {},
          backgroundColor: Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),
      ]),
      child: ListTile(
        title: Text('Элемент ${group}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => model.showTasks(context, idxList),
      ),
    );
  }
}
