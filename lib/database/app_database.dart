import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  //tudo o que vai ser executado vai ser dentro de um feature

  final String dbPath = await getDatabasesPath();

  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
        db.execute(ContactDao.tableSql);
    },
    version: 1,
//        onDowngrade: onDatabaseDowngradeDelete,
  ); //path é o caminho

//  //criando database
//  return getDatabasesPath().then((dbPath) {
//    final String path = join(dbPath, 'bytebanck.db');
//    return openDatabase(
//      path,
//      onCreate: (db, version) {
//        db.execute('CREATE TABLE contacts('
//            'id INTEGER PRIMARY KEY,'
//            'name TEXT,'
//            'account_number INTEGER)');
//      },
//      version: 1,
////          onDowngrade: onDatabaseDowngradeDelete,
//    ); //path é o caminho
//  });
}




