import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mydatabase/db/db_usuario.dart';
import 'package:mydatabase/models/task_model.dart';

class MyformWidget extends StatefulWidget {
  const MyformWidget({Key? key}) : super(key: key);

  @override
  State<MyformWidget> createState() => _MyformWidgetState();
}

class _MyformWidgetState extends State<MyformWidget> {

  final _formkey = GlobalKey<FormState>();

  bool isFinished = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  addTask(){

    if(_formkey.currentState!.validate()){

      TaskModel taskModel = TaskModel( 
      title: _titleController.text, 
      description: _descriptionController.text, 
      status: isFinished.toString(),
      );

    DBusuario.db.insertTask(taskModel).then((value){
      if(value > 0){
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        duration: const Duration(milliseconds: 1400),
      content: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "Tarea registrada con exito",
            ),
        ],
        )
      ),
    );
      }
    });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          content: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Agregar Tarea"),
                const SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "titulo"),
                  validator: (String? value){

                    if(value!.isEmpty){
                      return "El campo es obligatorio";
                    }
                    if(value.length <6){
                      return "Debe de tener min 6 Caracteres min";
                    }

                    return null;
                  }
                ),
                const SizedBox(
                  height: 6.0,
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(hintText: "Descripcion"),
                   validator: (String? value){

                    if(value!.isEmpty){
                      return "El campo es obligatorio";
                    }
                    if(value.length <6){
                      return "Debe de tener min 6 Caracteres min";
                    }

                    return null;
                  }
                ),
                const SizedBox(
                  height: 6.0,
                ),
          
                Row(
                  children: [
                    const Text("Estado"),
                    const SizedBox(
                      width: 6.0,
                    ),
                  Checkbox(
                    value: isFinished, 
                    onChanged: (value){
                      isFinished = value!;
                      setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text(
                        "Cancelar",
                        ),
                      ),
                    SizedBox(
                  height: 6.0,
                ),
                    ElevatedButton(
                      onPressed: (){
                        addTask();
                      }, 
                      child: Text(
                        "Aceptar",
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}