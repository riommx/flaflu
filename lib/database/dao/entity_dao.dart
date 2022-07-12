import 'package:simple_form_flutter/siddd/lib/library.dart';

class EntityDao {
  final Map<String, Entity> _entityMap = {};

  Future<void> save(Entity entity) async {
    _entityMap.putIfAbsent(
      entity.uid.getOrCrash,
      () => entity,
    );
  }

  Future<List<Entity>> findAll() async => _entityMap.values.toList();

  Future<void> delete(Entity entity) async =>
      _entityMap.remove(entity.uid.getOrCrash);

  Future<void> update(Entity entity) async {
    delete(entity);
    save(entity);
  }
}

/* import 'package:simple_form_flutter/siddd/lib/library.dart';

class EntityDao {
  final Map<String, Entity> _entityMap = {};

  void save(Entity entity) {
    _entityMap.putIfAbsent(
      entity.uid.getOrCrash,
      () => entity,
    );
  }

  List<Entity> findAll() => _entityMap.values.toList();

  void delete(Entity entity) => _entityMap.remove(entity.uid.getOrCrash);

  void updateContact(Entity entity) {
    delete(entity);
    save(entity);
  }
} */