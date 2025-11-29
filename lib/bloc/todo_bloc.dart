import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoLoading()) {
    on<LoadTodos>(_load);
    on<AddTodo>(_add);
    on<UpdateTodo>(_update);
    on<DeleteTodo>(_delete);
  }

  Future<void> _load(LoadTodos event, Emitter emit) async {
    final todos = await repository.loadTodos();
    emit(TodoLoaded(todos));
  }

  Future<void> _add(AddTodo event, Emitter emit) async {
    if (state is! TodoLoaded) return;
    final current = (state as TodoLoaded).todos;

    final newTodo = Todo(id: DateTime.now().toString(), title: event.title);

    final updated = [...current, newTodo];
    await repository.saveTodos(updated);
    emit(TodoLoaded(updated));
  }

  Future<void> _update(UpdateTodo event, Emitter emit) async {
    if (state is! TodoLoaded) return;
    final current = (state as TodoLoaded).todos;

    final updated = current.map((t) => t.id == event.todo.id ? event.todo : t).toList();
    await repository.saveTodos(updated);
    emit(TodoLoaded(updated));
  }

  Future<void> _delete(DeleteTodo event, Emitter emit) async {
    if (state is! TodoLoaded) return;
    final current = (state as TodoLoaded).todos;

    final updated = current.where((t) => t.id != event.todo.id).toList();
    await repository.saveTodos(updated);
    emit(TodoLoaded(updated));
  }
}

