import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService{
  static Future<String> uploadImage(Uint8List selectedImage, String itemKey) async{

    var metaData = SettableMetadata(contentType: 'image/jpeg');
    Reference ref = FirebaseStorage.instance.ref('images/test/$itemKey.jpg');

    await ref.putData(selectedImage, metaData)
        .catchError((onError){});
    return await ref.getDownloadURL();
  }
}

/// 추후 이 코드의 경우 재 확인 할 필요성이 있음.