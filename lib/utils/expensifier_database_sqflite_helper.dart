import 'dart:io';
import 'package:expensifier/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Expensifier_DB_Helper
{
  static Expensifier_DB_Helper expense_db = Expensifier_DB_Helper();

  Database? database ;

  final  dbPath = "dbase.db";
  final  dbTableName = "datatable";

  Future<Database?> checkDB()
  async {
    if(database != null)
      {
        return database;
      }
    else
      {
        return await buildDB();
      }
  }

  Future<Database> buildDB()
  async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbPath);
    String query = 'CREATE TABLE $dbTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, amount TEXT, status TEXT, category TEXT, paymentType TEXT, description TEXT ,date TEXT, time TEXT)';

    return await openDatabase(
      path, version: 1,
      onCreate: (db, version) async {return await db.execute(query);
    },);

  }

  Future<void> insertInDB(ExpenseModel expenseModel)
  async {
    database = await checkDB();

    await database!.insert(dbTableName, {
      'amount':expenseModel.amount,
      'status':expenseModel.status,
      'category':expenseModel.category,
      'description':expenseModel.description,
      'paymentType':expenseModel.paymentType,
      'date':expenseModel.date,
      'time':expenseModel.time
    }
    );

  }

  Future<List<Map>> readFromDB()
  async {
    database = await checkDB();
    String query = 'SELECT * FROM $dbTableName';
    List<Map> list = await database!.rawQuery(query);
    // print(list);
    return list;
  }

  Future<void> deleteInDB(int selId)
  async {
    database = await checkDB();
    database!.delete(dbTableName,where: "id=?" ,whereArgs:[selId] );
  }

  Future<void> updateInDB(ExpenseModel expenseModel)
  async {
    database = await checkDB();
    database!.update(dbTableName, {
      'amount':expenseModel.amount,
      'status':expenseModel.status,
      'category':expenseModel.category,
      'description':expenseModel.description,
      'paymentType':expenseModel.paymentType,
      'date':expenseModel.date,
      'time':expenseModel.time
    }, where: "id=?",whereArgs: [expenseModel.id]);

  }


  Future<List<Map>> readFilteredDB({cate,filterBy})
  async {
    database = await checkDB();
    String query = "";

  //  print("cate ==> $cate ${cate.length}  && filterBy ==> $filterBy");

    if(cate != "" && filterBy == "")
      {
        query = 'SELECT * FROM $dbTableName WHERE category = "$cate" ';
      }
    else if(cate == "" && filterBy != "")
      {
        query = 'SELECT * FROM $dbTableName WHERE status = "$filterBy" ';
      }
    else
      {
        query = 'SELECT * FROM $dbTableName WHERE category = "$cate" && status = "$filterBy" ';
      }
    List<Map> list = await database!.rawQuery(query);
    print(list);
    return list;
  }

  Future<List<Map<String, Object?>>> readMatheMatics(String status)
  async {
    database = await checkDB();
    String query = "";

    if(status == 'Income')
      {
        query = 'SELECT SUM(amount) FROM $dbTableName WHERE status = "Income"';

      }
    else if(status == 'Expense')
      {
        query = 'SELECT SUM(amount) FROM $dbTableName WHERE status = "Income"';

      }
     List<Map<String, Object?>> list = await database!.rawQuery(query);
     return list;
  }

}