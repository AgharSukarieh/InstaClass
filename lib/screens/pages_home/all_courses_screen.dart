import 'package:flutter/material.dart';
import 'package:insta_class/widgets/education_levels.dart';

// ignore: must_be_immutable
class AllCoursesPage extends StatefulWidget {
  final ScrollController? scrollController;

  int? isSelectCatgoers;
  AllCoursesPage({super.key, this.scrollController, this.isSelectCatgoers});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

final List<String> educationCategories = [
  "Seventh to Ninth Grade Subjects",
  "University Courses",
  "Browse Courses",
  "Tawjihi for All Branches",
];

final List<Map<String, dynamic>> courses = [
  {
    "category": "Elementary School Grades",
    "description":
        "Elementary School subjects including Seventh, Eighth, and Ninth grades.",
    "courses": ["Seventh Grade", "Eighth Grade", "Ninth Grade"],
  },
  {
    "category": "Tenth Grade",
    "description":
        "Tenth Grade subjects including Scientific, Literary, and more",
    "courses": [
      "Scientific",
      "Literary",
      "Common Subjects",
      "Vocational Branches",
      "Industrial",
    ],
  },
  {
    "category": "Eleventh Grade",
    "description": "Explore Eleventh Grade courses",
    "courses": [
      "Scientific",
      "Literary",
      "Common Subjects",
      "Vocational Branches",
      "Industrial",
    ],
  },
  {
    "category": "Tawjihi 2006 (Supplementary)",
    "description": "Supplementary Tawjihi 2006 courses ",
    "courses": [
      "Scientific",
      "Literary",
      "Common Subjects",
      "Vocational Branches",
      "Industrial",
    ],
  },
];

class _AllCoursesPageState extends State<AllCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return EducationLevels(courses: courses);
  }
}
