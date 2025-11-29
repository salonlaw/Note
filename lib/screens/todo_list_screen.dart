import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart';
import '../models/todo.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoLoaded) {
            final todos = state.todos;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, i) {
                final todo = todos[i];

                return ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      context.read<TodoBloc>().add(
                        UpdateTodo(todo.copyWith(isDone: !todo.isDone)),
                      );
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoBloc>().add(DeleteTodo(todo));
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTodoScreen(todo: todo),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTodoScreen()),
        ),
      ),
    );
  }
}
