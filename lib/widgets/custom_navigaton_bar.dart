import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final double opacity;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.opacity,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  Widget _buildAnimatedIcon({required int index, required String assetPath}) {
    bool isSelected = widget.selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: isSelected ? 10.0 : 0.0),
      child: ImageIcon(AssetImage(assetPath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double currentOpacity =
        (widget.selectedIndex == 0 || widget.selectedIndex == 1)
            ? 1.0
            : widget.opacity;

    return Opacity(
      opacity: currentOpacity,
      child: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  index: 0,
                  assetPath: "images/icons/icon_notes.png",
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  index: 1,
                  assetPath: "images/icons/icon_nycoures.png",
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  index: 2,
                  assetPath: "images/icons/icon_coures.png",
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildAnimatedIcon(
                  index: 3,
                  assetPath: "images/icons/icon_user.png",
                ),
                label: '',
              ),
            ],
            currentIndex: widget.selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: widget.onItemTapped,
          ),
        ),
      ),
    );
  }
}
