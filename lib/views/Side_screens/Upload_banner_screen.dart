import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({Key? key}) : super(key: key);

  static const String screenRoute = "UploadBannerScreen";

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  dynamic _image;
  String? _fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  Future<String?> _uploadToFirebaseStorage(dynamic image) async {
    try {
      var ref = _firebaseStorage.ref().child('Banner').child(_fileName!);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading to Firebase Storage: $e");
      return null;
    }
  }

  _uploadToFireStore() async {
    if (_image != null) {
      EasyLoading.show(); // Show loading indicator
      var imageURL = await _uploadToFirebaseStorage(_image);

      if (imageURL != null) {
        await _firebaseFirestore.collection("Banner").doc(_fileName).set({
          'image': imageURL,
        }).whenComplete(() {
          EasyLoading.dismiss(); // Dismiss loading indicator
          setState(() {
            _image = null;
          });
        });
      } else {
        EasyLoading.dismiss(); // Dismiss loading indicator in case of error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _image != null
                      ? Image.memory(_image)
                      : Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Text('Select Banner'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _uploadToFireStore();
                    },
                    child: Text('Save Banner'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
