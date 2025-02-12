import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _addTask() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _titleController.text,
          'content': _contentController.text,
          'completed': false,
        });
      });
      _titleController.clear();
      _contentController.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 28.0, // 폰트 크기 더 크게 조절
            fontWeight: FontWeight.w900, // 글씨를 더 굵게
            color: Colors.white, // 글자 색상을 흰색으로 변경
          ),
        ),
        backgroundColor: Colors.blueGrey, // 배경 색상 변경
        centerTitle: true, // 제목을 중앙 정렬
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontSize: 20.0, // 원하는 크기로 변경 가능
                  fontWeight: FontWeight.bold, // 굵기 조정
                  color: Colors.black, // 글자 색상을 검정색으로 변경
                ),
              ),
            ),
            SizedBox(height: 12.0), // Title과 Content 사이 간격 조정
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(
                  fontSize: 20.0, // 원하는 크기로 변경 가능
                  fontWeight: FontWeight.bold, // 굵기 조정
                  color: Colors.black, // 글자 색상을 검정색으로 변경
                ),
              ),
            ),
            SizedBox(height: 16.0), // Content 아래 간격 조정
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ListTile(
                      leading: Icon(
                        task['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.blueGrey,
                      ),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          fontSize: 20.0, // 원하는 크기로 변경 가능
                          fontWeight: FontWeight.bold, // 굵기 조정
                          color: Colors.black, // 글자 색상을 검정색으로 변경
                          decoration: task['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        task['content'],
                        style: TextStyle(
                          fontSize: 18.0, // 원하는 크기로 변경 가능
                          fontWeight: FontWeight.normal, // 기본 굵기 설정
                          color: Colors.black, // 글자 색상을 검정색으로 변경
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'delete') {
                            _deleteTask(index);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                      onTap: () => _toggleTaskCompletion(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
