import 'package:equib/equib_data/equip_model_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseExpense {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'memberList.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE memberList(id INTEGER PRIMARY KEY, name TEXT,memberID TEXT, price TEXT, phoneNumber TEXT, equibQuantity TEXT)''',
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

/*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
* */

class DatabaseTaker {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'takerList.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE takerList(id INTEGER PRIMARY KEY, member TEXT,takersID TEXT, amount TEXT,isWin int, round TEXT, day TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(TakerModel task) async {
    Database db = await database();
    int data = await db.insert('takerList', task.toMap());
    return data;
  }

  Future<List<TakerModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('takerList');
    List<TakerModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => TakerModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(TakerModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'takerList',
      item.toMap(),
      where: 'member = ?',
      whereArgs: [item.member],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM takerList WHERE member = '$id'");
  }
}

/*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
* */
class DatabaseEquipStarter {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'equipStartList.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE equipStartList(id INTEGER PRIMARY KEY, length TEXT, recurrence TEXT, member TEXT, amount TEXT,equipId TEXT, grandPrize TEXT, day TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(EquipStarterModel task) async {
    Database db = await database();
    int data = await db.insert('equipStartList', task.toMap());
    return data;
  }

  Future<List<EquipStarterModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('equipStartList');
    List<EquipStarterModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => EquipStarterModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(EquipStarterModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'equipStartList',
      item.toMap(),
      where: 'equipId = ?',
      whereArgs: [item.equipId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(String id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM equipStartList WHERE equipId = '$id'");
  }
}
