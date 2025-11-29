import '../models/todo.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  DeleteTodo(this.todo);
}
