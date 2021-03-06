part of 'shared.dart';

Future<File> getImage() async {
  // ignore: unused_local_variable
  File _image;
  final picker = ImagePicker();
  var pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
  return _image = File(pickedFile.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}
