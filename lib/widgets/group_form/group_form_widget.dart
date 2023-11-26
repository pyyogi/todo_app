import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({super.key});

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetProvider(
        model: model, child: const _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({
    super.key,
  });

  bool _isValid(String value) {
    return value.isNotEmpty;
  }

  void _saveGroup(BuildContext context, TextEditingController controller) {
    if (_isValid(controller.text)) {
      GroupFormWidgetProvider.read(context)?.model.saveGroup(context);
    }
  }

  void _cancel(BuildContext context) {
    Navigator.pop(context, 'Cancel');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final model = GroupFormWidgetProvider.read(context)?.model;
    return AlertDialog(
      title: Text('Создать новую группу'),
      content: TextField(
        autofocus: true,
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Имя группы',
        ),
        onChanged: (value) =>
            GroupFormWidgetProvider.read(context)?.model.groupName = value,
      ),
      actions: [
        TextButton(
          onPressed: () => _cancel(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _saveGroup(context, _controller),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
