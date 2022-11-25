import 'dart:io';
import 'package:mydatabase/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBusuario {
  Database? myDatabase;

  static final DBusuario db = DBusuario._();
  DBusuario._();

  Future<Database?> chekDatabase()  async{
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        await dbx.execute(
            "CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");
      },
    );
  }
  //primera metodo de insercion
Future<int> insertRawTask(TaskModel model) async{
  Database? db= await chekDatabase();
  int res = await db!.rawInsert(
    "INSERT INTO TASK(title, description, status) VALUES ('${model.title}','${model.description}','${model.status.toString()}')");
  return res;
  }

//segundo metodo de insercion
Future<int> insertTask(TaskModel model) async{
  Database? db = await chekDatabase();
  int res = await db!.insert(
    "TASK",
    {
      "title": model.title,
      "Description": model.description,
      "status": model.status,
      },
    );
    return res;
  }

  //verificacion de registros
  getRawTasks() async{
    Database? db = await chekDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Task");
    print(tasks);
  }
  
  Future<List<TaskModel>> getTasks() async{
    Database? db = await chekDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("Task");
    List<TaskModel> TaskModeList = tasks.map((e) => TaskModel.deMapAModel(e)).toList();

    //tasks.forEach((element) {
      ////TaskModel tasks = TaskModel.deMapAModel(element)
     //TaskModeList.add(TaskModel.deMapAModel(element));
   //});

    return TaskModeList;
  }

  //actualizar los datos
updateRawTask() async{
  Database? db = await chekDatabase();
  int res = await db!.rawUpdate("UPDATE TASK SET title = 'Ir de compras','description = 'Comprar comida', status ='true', WHERE id = 2    ");
  print(res);
  }
  //segundo metodo de actualisacion
updateTask() async{
  Database? db = await chekDatabase();
  db!.update("TASK", 
  {
    "title": "Ir al cine",
    "description": "Es el viernes en la tarde",
    "status" : "false",
      },
      where: "id = 2"
    );
  }

  //elimanar los datos
  deleteRawTask() async{
    Database? db = await chekDatabase();
    int res = await db!.rawDelete("DELETE FROM TASK WHERE id = 2");
    print(res);
  }
  //segundo metodo para eliminar
  deleteTask() async{
    Database? db = await chekDatabase();
    int res = await db!.delete("TASK", where: "id = 3");
  }
}




