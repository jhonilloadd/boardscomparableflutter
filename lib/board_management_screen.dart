import 'package:flutter/material.dart';
import 'api_service.dart';

class BoardManagementScreen extends StatefulWidget {
  BoardManagementScreen(this.apiService);

  ApiService apiService;
  @override
  _BoardManagementScreenState createState() => _BoardManagementScreenState();
}

class _BoardManagementScreenState extends State<BoardManagementScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String? _boardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Board Management')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Brand'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerBoard,
              child: Text('Register Board'),
            ),
            ElevatedButton(
              onPressed: _updateBoard,
              child: Text('Update Board'),
            ),
            ElevatedButton(
              onPressed: _deleteBoard,
              child: Text('Delete Board'),
            ),
          ],
        ),
      ),
    );
  }

  void _registerBoard() async {
    if (_nameController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _brandController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    try {
      final response = await widget.apiService.registerBoard({
        'name': _nameController.text,
        'model': _modelController.text,
        'brand': _brandController.text,
      });
      setState(() {
        _boardId = response.data['id'];
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Board registered successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register board: ${e.toString()}')));
    }
  }

  void _updateBoard() async {
    if (_boardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please register a board first')));
      return;
    }
    if (_nameController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _brandController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    try {
      await widget.apiService.updateBoard(_boardId!, {
        'name': _nameController.text,
        'model': _modelController.text,
        'brand': _brandController.text,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Board updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update board: ${e.toString()}')));
    }
  }

  void _deleteBoard() async {
    if (_boardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please register a board first')));
      return;
    }
    try {
      await widget.apiService.deleteBoard(_boardId!);
      setState(() {
        _boardId = null;
        _nameController.clear();
        _modelController.clear();
        _brandController.clear();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Board deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete board: ${e.toString()}')));
    }
  }
}
