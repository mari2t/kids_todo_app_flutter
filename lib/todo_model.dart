import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODOリストの状態管理を行うためのモデルクラス
// このクラスはChangeNotifierを継承しており、リスナーに変更通知を行うことができます。
class TodoModel extends ChangeNotifier {
  // 内部で保持しているTODOリスト
  List<String> _todos = [];

  // 外部からアクセス可能なTODOリストのゲッター
  List<String> get todos => _todos;

  // コンストラクタ
  // クラスが初期化されたときに、永続化されたTODOリストを読み込みます。
  TodoModel() {
    loadTodos(); // データの読み込みを実行
  }

  // TODOリストに新しいタスクを追加するメソッド
  void addTodo(String todo) {
    _todos.add(todo); // リストに新しいタスクを追加
    saveTodos(); // リストを永続化
    notifyListeners(); // リスナーに変更を通知（UI更新）
  }

  // 指定されたインデックスのタスクを削除するメソッド
  void removeTodoAt(int index) {
    _todos.removeAt(index); // 指定インデックスのタスクを削除
    saveTodos(); // リストを永続化
    notifyListeners(); // リスナーに変更を通知（UI更新）
  }

  // TODOリストをデバイスに保存するメソッド
  // SharedPreferencesを使ってローカルにデータを保存
  void saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todos', _todos); // リスト全体を保存
  }

  // デバイスからTODOリストを読み込むメソッド
  // SharedPreferencesから保存済みデータを読み込みます。
  void loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _todos = prefs.getStringList('todos') ?? []; // データが存在しない場合は空リストを返す
    notifyListeners(); // データを読み込んだらリスナーに通知（UI更新）
  }
}
