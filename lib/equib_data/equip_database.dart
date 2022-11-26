import 'package:equib/equib_data/equip_model_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseExpense {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'memberList.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE memberList(id INTEGER PRIMARY KEY, name TEXT, price TEXT, phoneNumber TEXT, equibQuantity TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(MembersModel task) async {
    Database db = await database();
    int data = await db.insert('memberList', task.toMap());
    return data;
  }

  Future<List<MembersModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('memberList');
    List<MembersModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => MembersModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(MembersModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'memberList',
      item.toMap(),
      where: 'name = ?',
      whereArgs: [item.name],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM memberList WHERE name = '$id'");
  }
}


