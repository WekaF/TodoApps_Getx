// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:todogetx/core/models/taks.dart';

class DbHelpe{
  static Database? _db;
  static const int _ver = 1;
  static const String _tableName = "task";

static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _ver, onCreate: (db, version) {
        print("creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, date STRING, "
          "startTime STRING, endTime STRING, "
          "remind INTEGER, repeat STRING, "
          "color INTEGER, "
          "isCompleted INTEGER, "
          "isCreated INTEGER, "
          "isDoing INTEGER, "
          "isDone INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

//   static Future<Database> initDB() async{
//     print('initDb execute');
//     String path = join(await getDatabasesPath(), 'task.db');
//     await deleteDatabase(path);
//     return await openDatabase(path, version: _ver,
//     onCreate: (Database _db, int version) async{
//       await _db.execute(tabletask);
//     }
//     );
//   }


//  static const tabletask = """
//   CREATE TABLE IF NOT EXISTS $_tableName (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title STRING, note TEXT, date String,
//         remind INTEGER, repeat STRING
//         color INTEGER,
//         isCompleted INTEGER,
//         isCreated INTEGER,
//         isDoing INTEGER,
//         isDone INTEGER
//       );""";


  // Future<Database?> get database async{
  //   if(_db != null ){
  //     return _db;
  //   }else{
  //     _db = await initDb();
  //     return _db;
  //   }
  // }

  static Future<int> insert(Task? task) async{
    print('insert called');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String,dynamic>>> query() async{
    print('query call');
    return await _db!.query(_tableName);
  }

  static deleted(Task task) async{
    return await _db?.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static update(int id) async{
    return await _db!.rawUpdate('''UPDATE task SET isCompleted = ? WHERE id = ? ''', [1, id]);
  }
}