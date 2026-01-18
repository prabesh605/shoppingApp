import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadService {
  String cloudName = 'dndihenwf';
  String preset = 'ecommerce';
  File? _image;
  String? imageUrl;

  Future<String?> pickImage() async {
    ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _image = File(picked.path);
      if (_image != null) {
        final url = await uploadImage();
        return url;
      }
    }
    return imageUrl;
  }

  Future<String> uploadImage() async {
    String uploadUrl =
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
    if (_image == null) return '';
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));
    request.fields['upload_preset'] = preset;
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var data = jsonDecode(res.body);
    imageUrl = data['secure_url'];
    return imageUrl ?? "";
    // print(imageUrl);
  }
}
