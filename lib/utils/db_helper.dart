import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:expense_tracker/home/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  // ignore: non_constant_identifier_names
  final String DB_NAME = "expense.db";
  final String db_table = "mytable";
  final String DB_amount='amount';
  final String DB_note='note';
  final String DB_cate='category';
  final String DB_date='date';
  final String DB_time='time';
  final String DB_status='status';

  // Income = 0
  // Expense = 1
  Database? dataBase;

  // ignore: body_might_complete_normally_nullable
  Future<Database?> checkDB() async {
    if (dataBase != null) {
      return dataBase;
    } else {
      return await initDB();
    }
  }

  Future<Database?> initDB() async {
    // ignore: unused_local_variable
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $db_table (id INTEGER PRIMARY KEY AUTOINCREMENT, $DB_amount INTEGER,$DB_note TEXT, $DB_cate TEXT, $DB_date TEXT, $DB_time TEXT, $DB_status INTEGER)');
      },
    );
    // ignore: avoid_print
    print(path);
    return dataBase;
  }

  Future<int> insertData(ExpenseIncomeModel model) async {
    await checkDB();
    return await dataBase!.insert(db_table, {
      DB_amount: model.amount,
      DB_note: model.notes,
      DB_date: model.date,
      DB_time: model.time,
      DB_status: model.status,
      DB_cate: model.cate,
    });
  }

  Future<List<Map>> readDB() async {
    dataBase = await checkDB();
    String query = 'SELECT * FROM $db_table';
    List<Map> l1 = await dataBase!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> cateReadDB({required category}) async {
    dataBase = await checkDB();
    String query = "SELECT * FROM $db_table WHERE $DB_cate='$category'";
    List<Map> l1 = await dataBase!.rawQuery(query);
    return l1;
  }

  Future<void> deleteData(int id)
  async {
    dataBase = await checkDB();
    dataBase!.delete(db_table,where: "id=?",whereArgs: [id]);
  }
  Future<int> updateDate(ExpenseIncomeModel modelupdate,int id)
  async {
    dataBase = await checkDB();
    return await dataBase!.update(db_table, {
      DB_amount: modelupdate.amount,
      DB_note: modelupdate.notes,
      DB_date: modelupdate.date,
      DB_time: modelupdate.time,
      DB_status: modelupdate.status,
      DB_cate: modelupdate.cate,
    },where: "id=?",whereArgs: [id]);
  }

  void filterdata()
  {
    
  }

}
