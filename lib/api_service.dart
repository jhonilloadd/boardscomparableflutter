import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = dotenv.env["API_URL"]!;

  Future<Response> registerBoard(Map<String, dynamic> boardData) async {
    try {
      final response = await _dio.post('$_baseUrl/boards', data: boardData);
      return response;
    } catch (e) {
      throw Exception('Failed to register board: $e');
    }
  }

  Future<Response> updateBoard(
      String boardId, Map<String, dynamic> boardData) async {
    try {
      final response =
          await _dio.put('$_baseUrl/boards/$boardId', data: boardData);
      return response;
    } catch (e) {
      throw Exception('Failed to update board: $e');
    }
  }

  Future<Response> deleteBoard(String boardId) async {
    try {
      final response = await _dio.delete('$_baseUrl/boards/$boardId');
      return response;
    } catch (e) {
      throw Exception('Failed to delete board: $e');
    }
  }
}
