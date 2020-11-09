import 'package:flutter/material.dart';
import 'package:sqllitedatabase_example/taskmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textcontroller = TextEditingController();
  List<TaskModel> tasks = [];
  TaskModel currentModel;
  final TodoHelper _todoHelper = TodoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(32),
            child: Column(children: <Widget>[
              TextField(
                controller: _textcontroller,
              ),
              FlatButton(
                child: Text("Insert"),
                onPressed: () {
                  currentModel = TaskModel(name: _textcontroller.text);
                  _todoHelper.insertTask(currentModel);
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
              FlatButton(
                child: Text("ShowList"),
                onPressed: () async {
                  List<TaskModel> list = await _todoHelper.getAllTask();
                  setState(() {
                    tasks = list;
                  });
                },
                color: Colors.green,
                textColor: Colors.white,
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tasks[index].id}"),
                    title: Text("${tasks[index].name}"),
                  );
                },
                itemCount: tasks.length,
                separatorBuilder: (context, index) => Divider(),
              ))
            ])));
  }
}
