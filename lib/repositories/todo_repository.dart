import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoRepository {
  static const String key = "todos";

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => Todo.fromMap(e)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(todos.map((e) => e.toMap()).toList());
    await prefs.setString(key, encoded);
  }
}
