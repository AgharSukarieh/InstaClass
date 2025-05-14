import 'package:flutter/material.dart';
import 'package:insta_class/screens/pages_home/all_courses_screen.dart';
import 'package:insta_class/screens/pages_home/profile_screen.dart';
import 'package:insta_class/screens/pages_home/subscribed_courses_screen.dart';
import 'package:insta_class/screens/pages_home/user_files_screen.dart';
import 'package:insta_class/widgets/custom_app_bar.dart';
import 'package:insta_class/widgets/custom_navigaton_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 2;
  double _opacity = kMaxOpacity;
  final ScrollController scrollController = ScrollController();
  double _lastOffset = 0.0;
  int selectSearch = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    scrollController.addListener(() {
      _updateOpacity(scrollController.offset);
    });
  }

  void _updateOpacity(double currentOffset) {
    setState(() {
      if (currentOffset > _lastOffset) {
        _opacity = (_opacity - kOpacityStep).clamp(kMinOpacity, kMaxOpacity);
      } else if (currentOffset < _lastOffset) {
        _opacity = (_opacity + kOpacityStep).clamp(kMinOpacity, kMaxOpacity);
      }
      _lastOffset = currentOffset;
    });
  }

  void onNavigationItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar:
          _selectedIndex == 2 || _selectedIndex == 3
              ? null
              // ? PreferredSize(
              //   preferredSize: Size.fromHeight(70),
              //   child: CustomAppBar(
              //     index: _selectedIndex,
              //     searchController: _searchController,
              //     tabController: _tabController,
              //     onStreamSelected: (value) {
              //       setState(() {
              //         selectSearch = value;
              //       });
              //     },
              //   ),
              // )
              : CustomAppBar(
                index: _selectedIndex,
                tabController: _tabController,
              ),

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const UserFilesPage(),
          SubscribedCourses(tabController: _tabController),
          AllCoursesPage(
            scrollController: scrollController,
            isSelectCatgoers: selectSearch,
          ),
          UserProfilePage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        opacity: _opacity,
        onItemTapped: onNavigationItemSelected,
      ),
    );
  }
}

const double kOpacityStep = 0.06;
const double kMinOpacity = 0.5;
const double kMaxOpacity = 1.0;
