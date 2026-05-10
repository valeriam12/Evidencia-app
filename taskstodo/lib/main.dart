import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Lista de Tareas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // Lista donde guardamos las tareas
  final List<String> _tasks = [];

  // Controlador para leer el texto del campo de entrada
  final TextEditingController _controller = TextEditingController();

  // Función para agregar una tarea
  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return; // No agregar tareas vacías

    setState(() {
      _tasks.add(text);
    });

    _controller.clear(); // Limpiar el campo de texto
  }

  // Función para eliminar una tarea por índice
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Lista de Tareas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Campo de texto para escribir una nueva tarea
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe una tarea...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(), // También agrega con Enter
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),

          // Mensaje cuando no hay tareas
          if (_tasks.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  '¡No tienes tareas pendientes! 🎉',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          else
            // Lista de tareas
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.check_circle_outline,
                          color: Colors.indigo),
                      title: Text(_tasks[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
