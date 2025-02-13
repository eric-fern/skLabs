import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class ImageUploadSection extends StatefulWidget {
  final Function(String)?
      onTextReceived; // Callback for when we get API response

  const ImageUploadSection({
    super.key,
    this.onTextReceived,
  });

  @override
  State<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  String? _imageUrl;
  String? _errorMessage;

  Future<void> _sendImageToApi(html.File file) async {
    try {
      // Convert image to base64
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      final bytes = reader.result as List<int>;
      final base64Image = base64Encode(bytes);

      // Send to API
      final response = await http.post(
        Uri.parse(ApiConfig.imageProcessingUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Assuming API returns a 'text' field with the extracted text
        if (widget.onTextReceived != null) {
          widget.onTextReceived!(responseData['text']);
        }
      } else {
        setState(() => _errorMessage = 'API Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error sending image: $e');
    }
  }

  void _handleClick() {
    final input = html.FileUploadInputElement()..click();
    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file != null) _handleFile(file);
    });
  }

  void _handleFile(html.File file) async {
    if (!file.type.contains('jpg') && !file.type.contains('jpeg')) {
      setState(() => _errorMessage = 'Please upload a JPG/JPEG image');
      return;
    }

    if (_imageUrl != null) html.Url.revokeObjectUrl(_imageUrl!);
    _imageUrl = html.Url.createObjectUrlFromBlob(file);
    setState(() => _errorMessage = null);

    // Send to API after successful upload
    await _sendImageToApi(file);
  }

  @override
  void dispose() {
    if (_imageUrl != null) html.Url.revokeObjectUrl(_imageUrl!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 360,
          height: 640,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(_imageUrl!, fit: BoxFit.cover),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload,
                        color: Colors.white, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Click to upload',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
