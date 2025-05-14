import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';

class CoursesGridWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Map<String, dynamic>> courses;

  const CoursesGridWidget({
    Key? key,
    this.scrollController,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 3 : 2,
        childAspectRatio: isLandscape ? 1.5 : 0.8,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final item = courses[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(200, 211, 211, 224),
                offset: Offset(-2.5, 3),
                spreadRadius: 0.1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    item["images"],
                    fit: BoxFit.cover,
                    height: isLandscape ? 80 : 120,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    item["CouesName"],
                    style: TextStyle(color: AppColors.success),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          item["imageTecher"],
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            item["nameTechers"],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
