import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuctionImage with ChangeNotifier {

  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImages = [];
  int _count = 0;

  List<XFile> get images => _pickedImages;
  int get count => _count;

  Future<void> getImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      _count += images.length;
      _pickedImages.addAll(images);
      notifyListeners();
    }
  }
}