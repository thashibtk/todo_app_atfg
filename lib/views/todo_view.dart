import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/adapters/todo_adapter.dart';
import 'package:todo/views/add_todo.dart';

class TodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
      ),
      appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Task Manager",
            style: GoogleFonts.dancingScript(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          actions: [
            Container(
              width: 50,
              child: Image.network(
                  'https://img.icons8.com/color/452/google-calendar--v1.png'),
            )
          ]),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text("No data available!",
                  style: TextStyle(fontFamily: 'Montserrat')),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo todo = box.getAt(index);
                return ListTile(
                  onLongPress: () async {
                    await box.deleteAt(index);
                  },
                  title: Text(
                    todo.title,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  subtitle: Text(
                    todo.date.toString() + "\n" + todo.description,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                );
              });
        },
      ),
    );
  }
}
