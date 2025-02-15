import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/theme/app_theme.dart';
import '../core/services/service_locator.dart';
import '../core/constants/api_constants.dart';
import 'dart:io';

class ImageUploadSection extends StatefulWidget {
  final Function(String)? onTextReceived;
  const ImageUploadSection({super.key, this.onTextReceived});

  @override
  State<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  String? _imageUrl;
  String? _errorMessage;
  final _picker = ImagePicker();

  Future<void> _uploadAndProcess() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      if (!image.name.toLowerCase().endsWith('.jpg') &&
          !image.name.toLowerCase().endsWith('.jpeg')) {
        setState(() => _errorMessage = 'Please upload a JPG/JPEG image');
        return;
      }

      final bytes = await image.readAsBytes();
      setState(() {
        _imageUrl = null;
        _errorMessage = null;
      });

      final response = await ServiceLocator().apiService.sendImage(
            endpoint: ApiConstants.imageProcessEndpoint,
            imageBytes: bytes,
            filename: image.name,
            headers: ApiConstants.multipartHeaders,
          );

      setState(() => _imageUrl = image.path);

      if (response.containsKey('text')) {
        widget.onTextReceived?.call(response['text'] as String);
      } else {
        setState(() => _errorMessage = 'Invalid response format');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _uploadAndProcess,
        child: Container(
          width: AppSpacing.imageUploadSize.width,
          height: AppSpacing.imageUploadSize.height,
          decoration: AppBorders.uploadContainer,
          child: _imageUrl != null
              ? ClipRRect(
                  borderRadius: AppBorders.defaultBorderRadius,
                  child: Image.file(
                    File(_imageUrl!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload,
                        color: AppColors.textLight, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Click to upload',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 14,
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      );
}
