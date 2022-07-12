import 'package:flutter/material.dart';
import 'package:simple_form_flutter/components/contatos/item_contato.dart';
import 'package:simple_form_flutter/models/contato.dart';
import 'package:simple_form_flutter/siddd/lib/library.dart';

import '../../database/dao/entity_dao.dart';

class EntityList extends StatefulWidget {
  final EntityDao dao;

  const EntityList({
    Key? key,
    required this.dao,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntityListState(dao);
  }
}

class EntityListState extends State<EntityList> {
  final EntityDao dao;
  EntityListState(this.dao);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5EBFD),
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FutureBuilder(
          future: dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final entities = dao.findAll() as List<Entity>;
                return ListView.builder(
                  itemCount: entities.length,
                  itemBuilder: (context, index) {
                    final Entity entity = entities[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        Formularioentity(entityUpdate: entity)))
                              },
                          child: Itementity(entity)),
                    );
                  },
                );
            }

            return const Center(child: Text('Unknown Error'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const FormularioContato();
          })).then((id) => setState(() {}));
        },
      ),
    );
  }
}
