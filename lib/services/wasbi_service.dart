import 'dart:io';

import 'package:minio/minio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WasbiService {
  // final minio = Minio(
  //   endPoint: 's3.eu-central-1.wasabisys.com',
  //   accessKey: 'Q0SDLP95K27ZJ1C3Z9K0',
  //   secretKey: '3nwMoYVwu7TaHp0OIB8i9guBeWWwV2taLiI7oWrX',
  //   useSSL: true,
  //   region: 'eu-central-1',
  // );
  // void testConnection() async {
  //   try {
  //     final buckets = await minio.listBuckets();
  //     for (var bucket in buckets) {
  //       print(
  //         '===========================================================================Bucket: ${bucket.name}',
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     print(
  //       '=====================================================================❌ خطأ في الاتصال بـ Wasabi: $e',
  //     );
  //     print('$stackTrace');
  //   }
  // }

  // Future<String> downloadVideo(String bucket, String objectName) async {
  //   try {
  //     // الحصول على مسار التخزين المؤقت
  //     String tempPath = await getDatabasesPath();
  //     Directory tempDir = Directory(tempPath);
  //     String filePath = "${tempDir.path}/$objectName";

  //     // فتح ملف للكتابة
  //     File file = File(filePath);
  //     IOSink sink = file.openWrite();

  //     // تحميل الفيديو من Wasabi وكتابته في الملف
  //     MinioByteStream stream = await minio.getObject(bucket, objectName);
  //     await for (final chunk in stream) {
  //       sink.add(chunk);
  //     }

  //     // إغلاق الملف بعد الكتابة
  //     await sink.flush();
  //     await sink.close();

  //     print("✅ تم تحميل الفيديو وحفظه في: $filePath");
  //     return filePath;
  //   } catch (e) {
  //     print("❌ خطأ أثناء تحميل الفيديو: $e");
  //     return "";
  //   }
  // }

  // // Future<void> uploadVideo() async {
  // //   try {
  // //     await minio.fPutObject("my-educational-videos", "test", filePath);
  // //     print("تم رفع الفيديو بنجاح");
  // //   } catch (e) {
  // //     print("خطأ في رفع الفيديو: $e");
  // //   }
  // // }
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      print("🔹 تم منح إذن الوصول للملفات");
    } else {
      print("❌ لم يتم منح الإذن، يرجى تمكينه يدويًا");
    }
  }

  // Future<void> pickAndUploadVideo() async {
  //   await requestStoragePermission();
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.video,
  //   );
  //   if (result != null) {
  //     String filePath = result.files.single.path!;
  //     String objectName = result.files.single.name; 

  //     // await uploadVideoMultipart(filePath);
  //   }
  // }

  // Future<void> uploadVideoMultipart(String filePath) async {
  //   try {
  //     final bucket = "my-educational-videos";
  //     final objectName = "VID-${DateTime.now().millisecondsSinceEpoch}.mp4";

  //     final file = File(filePath);
  //     final fileSize = await file.length();
  //     final stream = file.openRead().map(
  //       (chunk) => Uint8List.fromList(chunk),
  //     ); // ✅ تحويل List<int> إلى Uint8List

  //     await minio.putObject(
  //       bucket,
  //       objectName,
  //       stream,
  //       size: fileSize,
  //     );

  //     print("✅ تم رفع الفيديو بنجاح: $objectName");
  //   } catch (e) {
  //     print("❌ خطأ في رفع الفيديو: $e");
  //   }
  // }

  // Future<void> listVideos() async {
  //   try {
  //     final objects = await minio.listObjects('my-educational-videos');
  //     await for (var obj in objects) {
  //       print("📂 موجود في الباكت: ${obj.objects}");
  //     }
  //   } catch (e) {
  //     print("❌ خطأ أثناء جلب الملفات: $e");
  //   }
  // }
  // Future<void> downloadVideo(String bucket, String objectName, String savePath) async {
  //   try {
  //     // تحميل الفيديو باستخدام دالة getObject
  //     final response = await minio.getObject(bucket, objectName);

  //     // حفظ الملف إلى المسار المحدد
  //     final file = File(savePath);
  //     await file.writeAsBytes(await response.stream.toBytes());

  //     print('تم تحميل الفيديو بنجاح: $savePath');
  //   } catch (e) {
  //     print('❌ خطأ في تحميل الفيديو: $e');
  //   }
  // }

  Future<void> loadJsonFile() async {
    String jsonString = await rootBundle.loadString(
      'assets/service_account.json',
    );
    var jsonData = jsonDecode(jsonString);
    print(jsonData);
  }
}
