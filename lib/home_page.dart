import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mydatabase/models/task_model.dart';
import 'package:mydatabase/widgets/my_form_widget.dart';
import 'db/db_usuario.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future<String> getFullName() async{
    return "Juan Manuel";
  }

  showDialogForm(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return MyformWidget();
      },
    ).then((value){
      print("El formulario fue cerrado");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialogForm();
        },
        child: const Icon(Icons.add),
      ),

      body: FutureBuilder(
        future: DBusuario.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snap){
          if(snap.hasData){
            List<TaskModel> myTasks = snap.data;
          return ListView.builder(
            itemCount: myTasks.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title:  Text(myTasks[index].title),
                subtitle: Text(myTasks[index].description),
                trailing: Text(myTasks[index].id.toString()),
                  );
               },
            );
          }
          return const Center(
              child: CircularProgressIndicator(),
              );
        },
      ),
    );
  }
}