import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'repositories/todo_repository.dart';
import 'screens/todo_list_screen.dart';
import 'bloc/todo_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => TodoRepository(),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(context.read<TodoRepository>())..add(LoadTodos()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const TodoListScreen(),
        ),
      ),
    );
  }
}
