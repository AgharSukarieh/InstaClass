import 'package:flutter/material.dart';
import 'package:insta_class/screens/courses_page.dart';

List listImages = [
  "PrimarySchool.jpg",
  "tenth.jpg",
  "eleventh.jpg",
  "tw.jpg",
  "tw.jpg",
  "MiddleSchool.jpg",
  "HighSchool.jpg",
  "Academic.jpg",
];

class EducationLevels extends StatefulWidget {
  final List<Map<String, dynamic>> courses;

  const EducationLevels({Key? key, required this.courses}) : super(key: key);

  @override
  _EducationLevelsState createState() => _EducationLevelsState();
}

class _EducationLevelsState extends State<EducationLevels> {
  int selectedCourseIndex = -1;
  int? selectedSubjectIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedCourseIndex >= 0 && selectedSubjectIndex != null) {
      final selectedSubject =
          widget.courses[selectedCourseIndex]["courses"][selectedSubjectIndex!];
      return PageCourses(
        onBack: () {
          setState(() {
            selectedCourseIndex = -1;
            selectedSubjectIndex = null;
          });
        },
        c: selectedSubject,
      );
    }

    return ListView.builder(
      itemCount: widget.courses.length,
      itemBuilder: (context, index) {
        final courseMap = widget.courses[index];
        final courseTitle = courseMap['category'];
        final courseDesc = courseMap['description'];
        final subjectList = courseMap['courses'] as List<String>;

        return CourseTile(
          courseTitle: courseTitle,
          coursedesc: courseDesc,
          subjects: subjectList,
          index: index,
          onSelectSubject: (courseIndex, subjectIndex) {
            setState(() {
              selectedCourseIndex = courseIndex;
              selectedSubjectIndex = subjectIndex;
            });
          },
        );
      },
    );
  }
}

class CourseTile extends StatefulWidget {
  final String courseTitle;
  final String coursedesc;
  final List<String> subjects;
  final int index;
  final Function(int, int) onSelectSubject;

  const CourseTile({
    Key? key,
    required this.courseTitle,
    required this.coursedesc,
    required this.subjects,
    required this.index,
    required this.onSelectSubject,
  }) : super(key: key);

  @override
  _CourseTileState createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 120),
            child: ExpansionTile(
              leading: Container(
                width: 70,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    "images/${listImages[widget.index]}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(
                widget.courseTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.coursedesc),
              trailing: ImageIcon(
                AssetImage(
                  _isExpanded
                      ? "images/icons/icon_down_arrow.png"
                      : "images/icons/icon_up_arrow.png",
                ),
              ),
              onExpansionChanged: (bool expanding) {
                setState(() {
                  _isExpanded = expanding;
                });
              },
              children:
                  widget.subjects.asMap().entries.map((entry) {
                    int subjectIndex = entry.key;
                    String subject = entry.value;
                    return ListTile(
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Colors.deepPurpleAccent,
                      ),
                      title: Text(subject),
                      onTap: () {
                        widget.onSelectSubject(widget.index, subjectIndex);
                      },
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
