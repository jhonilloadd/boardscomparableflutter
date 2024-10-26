import 'dart:ffi';

import 'package:boardscomparableflutter/model/board.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = dotenv.env["API_URL"]!;

  Future<Board> registerBoard(Board board) async {
    final response = await _dio.post('$_baseUrl/boards', data: board.toJson());

    if (response.statusCode == 201) {
      return Board().fromJson(response.data);
    } else {
      throw Exception('Failed to register board');
    }
  }

  Future<Board> updateBoard(Int boardId, Board boardData) async {
    try {
      final response =
          await _dio.put('$_baseUrl/boards/$boardId', data: boardData.toJson());

      if (response.statusCode == 201) {
        return Board().fromJson(response.data);
      } else {
        throw Exception('Failed to update board!');
      }
    } catch (e) {
      throw Exception('Failed to update board: $e');
    }
  }

  Future<bool> deleteBoard(Int boardId) async {
    try {
      final response = await _dio.delete('$_baseUrl/boards/$boardId');

      if (response.statusCode == 201) {
        return Board().fromJson(response.data);
      } else {
        throw Exception('Failed to delete board');
      }
    } catch (e) {
      throw Exception('Failed to delete board: $e');
    }
  }

  Future<List<Board>> getBoards() async {
    try {
      List<Board> lista = [];

      final response = await _dio.get('$_baseUrl/boards');
      if (response.statusCode == 201) {
        for (var element in response.data) {
          lista.add(Board().fromJson(element));
        }
        return lista;
      } else {
        throw Exception('Failed to get board!');
      }
    } catch (e) {
      throw Exception('Failed to get board: $e');
    }
  }
}
