import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // تأكد من إضافتها في pubspec.yaml
import 'package:flutter/material.dart';
import 'package:insta_class/services/wasbi_service.dart';
import 'package:insta_class/view_models/data_from_firestore_view_model.dart';
import 'package:provider/provider.dart';

class SubscribedCourses extends StatefulWidget {
  final TabController tabController;
  const SubscribedCourses({Key? key, required this.tabController})
    : super(key: key);

  @override
  State<SubscribedCourses> createState() => _SubscribedCoursesState();
}

class _SubscribedCoursesState extends State<SubscribedCourses> {
  WasbiService wasbiService = WasbiService();
  late List<Map<String, dynamic>>? info;

  @override
  Widget build(BuildContext context) {
    DataFromFirestoreViewModel dataViewModel =
        Provider.of<DataFromFirestoreViewModel>(context);
    return TabBarView(
      controller: widget.tabController,
      children: [
        // تبويب "Get Courses" يقوم بتنفيذ وظيفة معينة (مثلاً تحميل JSON أو جلب الدورات)
        Center(
          child: MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              wasbiService.loadJsonFile();
            },
            child: const Text(
              "get Courses",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // تبويب "My Courses" يحتوي على زر لرفع الفيديو
        Center(
          child: MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              // استدعاء وظيفة اختيار ورفع الفيديو
              await uploadVideoToFolder();
            },
            child: const Text(
              "My Courses",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadVideoToFolder() async {
    // اختيار فيديو من الجهاز
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      String filePath = result.files.single.path!;
      File videoFile = File(filePath);

      try {
        // إنشاء اسم فريد للفيديو
        String fileName = "VID-${DateTime.now().millisecondsSinceEpoch}.mp4";

        // تحديد المسار داخل المجلد 'my-folder'
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("my-folder")
            .child(fileName);

        // رفع الفيديو إلى المجلد
        UploadTask uploadTask = ref.putFile(videoFile);
        TaskSnapshot snapshot = await uploadTask;

        // الحصول على رابط التنزيل بعد الرفع
        String url = await snapshot.ref.getDownloadURL();
        print("✅ تم رفع الفيديو بنجاح. رابط التنزيل: $url");
      } catch (e) {
        print("❌ خطأ في رفع الفيديو: $e");
      }
    } else {
      print("❌ لم يتم اختيار فيديو.");
    }
  }
}
