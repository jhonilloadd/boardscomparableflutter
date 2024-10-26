import 'dart:ffi';

import 'package:boardscomparableflutter/model/board.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BoardView extends StatefulWidget {
  BoardView(this.apiService);

  ApiService apiService;
  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  Int? _boardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Board Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _modelController,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerBoard,
              child: const Text('Register Board'),
            ),
            ElevatedButton(
              onPressed: _updateBoard,
              child: const Text('Update Board'),
            ),
            ElevatedButton(
              onPressed: _deleteBoard,
              child: const Text('Delete Board'),
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    try {
      var board = Board(
          name: _nameController.text,
          model: _modelController.text,
          brand: _brandController.text);
      final response = await widget.apiService.registerBoard(board);
      setState(() {
        _boardId = response.id!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Board registered successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register board: ${e.toString()}')));
    }
  }

  void _updateBoard() async {
    if (_boardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please register a board first')));
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
      var board = Board(
          name: _nameController.text,
          model: _modelController.text,
          brand: _brandController.text);
      await widget.apiService.updateBoard(_boardId!, board);
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
