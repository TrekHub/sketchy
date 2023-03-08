import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class Task extends StateNotifier<List<String>> {
  Task() : super([]);

  void addTask(String task) {
    state = [...state, task];
  }
}

//creating the task provider

/*
 StateNotifierProvider which takes in a Task class and and a list of strings
*/
final taskProvider = StateNotifierProvider<Task, List<String>>((ref) {
  return Task();
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  // final List<String> tasks = [
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sketchy'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final tasks = ref.watch(taskProvider);

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter a task',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(taskProvider.notifier).addTask(_controller.text);
                    _controller.clear();
                  },
                  child: const Text('Add Task'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
