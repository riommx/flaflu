import 'package:flutter/material.dart';
import 'package:simple_form_flutter/siddd/lib/library.dart';

import 'delete_entity.dart';

class EntityCard extends StatelessWidget {
  final Entity entity;
  final String title;
  final String subtitle;

  // ignore: use_key_in_widget_constructors
  const EntityCard({
    required this.entity,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.person,
          size: 36,
          color: Color(0XFF97ace5),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: DeleteEntity(title: title, entity: entity),
      ),
    );
  }
}
