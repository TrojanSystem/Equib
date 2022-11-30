import 'package:equib/equib_data/equip_model_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DailyEquipCollectedDatabase {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dailyEquibCollected.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE dailyEquibCollected(id INTEGER PRIMARY KEY,isAllDay int,event TEXT,meetingID TEXT,totalPayed TEXT, price TEXT, fromDay TEXT, toDay TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(Meeting task) async {
    Database db = await database();
    int data = await db.insert('dailyEquibCollected', task.toMap(),);
    return data;
  }

  Future<List<Meeting>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('dailyEquibCollected');
    List<Meeting> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => Meeting.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(Meeting item) async {
    final Database db = await database();
    final rows = await db.update(
      'dailyEquibCollected',
      item.toMap(),
      where: 'event = ?',
      whereArgs: [item.event],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }


  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM dailyEquibCollected WHERE id = '$id'");
  }
}


