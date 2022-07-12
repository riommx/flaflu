import 'package:flutter/material.dart';
import 'package:simple_form_flutter/siddd/lib/library.dart';

import '../../database/dao/entity_dao.dart';

class DeleteEntity extends StatelessWidget {
  final String title;
  final Entity entity;
  final EntityDao dao;

  const DeleteEntity({
    Key? key,
    required this.title,
    required this.entity,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Atenção'),
          content: Text('Deseja mesmo excluir o contato $title ?'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      dao.delete(entity),
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const EntityList()),
                        ModalRoute.withName('/'),
                      )
                    },
                    child: const Text('Sim'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.redAccent,
        size: 36,
      ),
    );
  }
}
