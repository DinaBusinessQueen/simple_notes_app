import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const NoteTile(
      {super.key,
      required this.text,
      this.onEditPressed,
      this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          icon: const Icon(Icons.more_vert),
          items: const <DropdownMenuItem<String>>[
            DropdownMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Обновить'),
                ],
              ),
            ),
            DropdownMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Удалить'),
                ],
              ),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue == 'edit') {
              onEditPressed?.call();
            } else if (newValue == 'delete') {
              onDeletePressed?.call();
            }
          },
        ),
      ),
    );
  }
}
