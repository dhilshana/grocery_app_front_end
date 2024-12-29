import 'package:flutter/material.dart';
import 'package:grocery_app/services/apiServices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class AddReviewViewModel extends ChangeNotifier {
  bool viewReviewLoading = false;
  int? userId;
  final ApiServices apiServices = ApiServices();
  final List<XFile> images = [];
  final ImagePicker _imagePicker = ImagePicker();

  // Method to add a review
  void addReviewUiHandler(
    BuildContext context, {
    required int productId,
    required String description,
    required int rating,
  }) async {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image.')),
      );
      return;
    }

    try {
      viewReviewLoading = true;
      notifyListeners();

      userId = await apiServices.getId();
      if (userId == null) {
        throw Exception("User ID not found.");
      }

      // Prepare image files
      List<File> imageFiles = images.map((image) => File(image.path)).toList();

      final result = await apiServices.addReview(
        productId: productId,
        userId: userId!,
        description: description,
        rating: rating,
        images: imageFiles,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Review added successfully.')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      viewReviewLoading = false;
      notifyListeners();
    }
  }

  // Request specific permissions
  Future<void> _requestPermission(Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission is required.')),
      );
    }
  }

  // Pick images from a source
Future<void> _pickImage(ImageSource source, BuildContext context) async {
  try {
    if (source == ImageSource.gallery) {
      // Allow multiple images for gallery
      final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        if (images.length + pickedFiles.length > 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You can upload up to 5 images only.')),
          );
        } else {
          images.addAll(pickedFiles);
          notifyListeners();
        }
      }
    } else if (source == ImageSource.camera) {
      // Allow single image for camera
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        if (images.length >= 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You can upload up to 5 images only.')),
          );
        } else {
          images.add(pickedFile);
          notifyListeners();
        }
      }
    }
  } catch (e) {
    debugPrint('Error picking image: $e');
  }
}


  // Show image source dialog
  void showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                await _requestPermission(Permission.camera, context);
                _pickImage(ImageSource.camera,context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _requestPermission(Permission.storage, context);
                _pickImage(ImageSource.gallery,context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
