import 'package:flutter/material.dart';
import 'package:insta_class/widgets/CoursesGridWidget.dart';

List<Map<String, dynamic>> listtest = [
  {
    "images": "images/Math.jpg",
    "CouesName": "Physics Al",
    "imageTecher": "images/moh.jpeg",
    "nameTechers": "T.mouhammad alnjar",
  },
  {
    "images": "images/physics.jpg",
    "CouesName": "Physics Al",
    "imageTecher": "images/ph.jpeg",
    "nameTechers": "T.mouhammad alnjar",
  },
];

class PageCourses extends StatelessWidget {
  final VoidCallback? onBack;
  final dynamic c;
  const PageCourses({Key? key, this.onBack, this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$c"),
        centerTitle: true,
        leading: IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
      ),
      body: CoursesGridWidget(courses: listtest),
    );
  }
}
