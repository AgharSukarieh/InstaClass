import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int index;
  final TabController? tabController;
  const CustomAppBar({Key? key, required this.index, this.tabController})
    : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(120);
}

List<String> educationStreams = [
  "Scientific Branch",
  "Iiterary Branch",
  "Industrial Branch",
  "Common Subjects",
  "School Subjects",
  "Combined Branch",
];

class _CustomAppBarState extends State<CustomAppBar> {
  int? isSelected;

  @override
  Widget build(BuildContext context) {
    final translation = Provider.of<LocalizationViewModel>(context);
    switch (widget.index) {
      case 0:
        return AppBar(
          backgroundColor: AppColors.primaryDark,
          toolbarHeight:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 50
                  : 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Insta",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Class",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 40
                  : 60,
            ),
            child: Container(
              color: AppColors.background,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 40
                      : 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: educationStreams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = index;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              index == isSelected
                                  ? AppColors.primaryDark
                                  : AppColors.Textgray,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  index == isSelected
                                      ? AppColors.primaryDark
                                      : AppColors.Textgray,
                              offset: const Offset(-0.5, 3),
                              spreadRadius: index == isSelected ? 2 : 0,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Center(
                            child: Text(
                              " ${translation.translate("${educationStreams[index]}")} ",
                              style: TextStyle(
                                color:
                                    index == isSelected
                                        ? AppColors.background
                                        : AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      case 1:
        return AppBar(
          backgroundColor: AppColors.greyLight,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Insta",
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Class",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppColors.primaryDark,
            labelColor: AppColors.primaryDark,
            controller: widget.tabController,
            tabs: [
              Tab(text: "${translation.translate("Courses")}"),
              Tab(text: "${translation.translate("Files Archive")}"),
            ],
          ),
        );
      case 2:
        return AppBar(
          backgroundColor: AppColors.primaryDark,
          toolbarHeight:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 50
                  : 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Insta",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Class",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        );
      default:
        return AppBar(title: const Text("InstaClass"), centerTitle: true);
    }
  }
}
