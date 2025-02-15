import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  // For sending text data and receiving JSON response
  Future<Map<String, dynamic>> sendText({
    required String endpoint,
    required String text,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException('Failed to send text: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error sending text: $e');
    }
  }

  // For sending image data and receiving JSON response
  Future<Map<String, dynamic>> sendImage({
    required String endpoint,
    required Uint8List imageBytes,
    String filename = 'image.jpg',
    Map<String, String>? headers,
  }) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));

      // Add headers if provided
      if (headers != null) {
        request.headers.addAll(headers);
      }

      // Add the image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: filename,
        ),
      );

      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException('Failed to send image: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error sending image: $e');
    }
  }

  // For downloading images
  Future<Uint8List> downloadImage({
    required String imageUrl,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(imageUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw HttpException('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Error downloading image: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => message;
}
