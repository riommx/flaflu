/* import 'package:path/path.dart';
import 'package:simple_form_flutter/database/dao/contato_dao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  final String path = join(await getDatabasesPath(), 'simpleForm.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContatoDao.tableSql);
  }, version: 1); //onDowngrade: onDatabaseDowngradeDelete

}
 */



