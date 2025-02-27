import 'package:flutter/material.dart';
import 'package:todoapp/services/todo_services.dart';
import 'package:todoapp/utills/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      desController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit ToDo' : 'Add to do')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: desController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : 'Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //get data from form
    final title = titleController.text;
    final des = desController.text;
    final body = {"title": title, "description": des, "is_completed": false};
    //submit to the server

    final isSuccess = await TodoServices.addToDo(body);
    //show success or fails message
    if (isSuccess) {
      titleController.text = '';
      desController.text = '';
      showSuccessMesage(context, message: 'Creation success');
    } else {
      showErrorMesage(context, message: 'Creation false');
    }
  }

  Future<void> updateData() async {
    //get data from form
    final todo = widget.todo;
    if (todo == null) {
      print('You cannot call updated without data');
      return;
    }
    final id = todo['_id'];

    final title = titleController.text;
    final des = desController.text;
    final body = {"title": title, "description": des, "is_completed": false};
    //submit to the server

    final isSuccess = await TodoServices.updateTodo(id, body);

    //show success or fails message
    if (isSuccess) {
      showSuccessMesage(context, message: 'Updated success');
    } else {
      showErrorMesage(context, message: 'Updated false');
    }
  }
}
