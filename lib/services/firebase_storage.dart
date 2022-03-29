import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  static Future<String> downloadURLExample(String fr) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('fruits/default.png')
        .getDownloadURL();
    try {
      fr = fr.replaceAll(' ', '');
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('fruits/' + fr + '.png')
          .getDownloadURL();
    } catch (e) {
      print(e);
    }
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }
}
