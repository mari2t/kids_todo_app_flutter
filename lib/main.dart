import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // TodoModelをプロバイダーとして登録し、全体で使用可能にする
      create: (context) => TodoModel(),
      child: MyApp(),
    ),
  );
}

// メインのアプリクラス
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids TODO App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // アプリ全体のテーマカラーを青に設定
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todoModel = Provider.of<TodoModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TODOリスト'),
      ),
      body: ListView.builder(
        itemCount: todoModel.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoModel.todos[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => todoModel.removeTodoAt(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTodo = '';
              return AlertDialog(
                title: Text('新しいTODOを追加'),
                content: TextField(
                  onChanged: (value) {
                    newTodo = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (newTodo.isNotEmpty) {
                        todoModel.addTodo(newTodo);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('追加'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
