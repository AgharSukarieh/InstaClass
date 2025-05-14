import 'package:flutter/material.dart';
import 'package:insta_class/models/database_helper.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// import 'package:syriaapp/view_models/auth_viewmodel.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

List iconTitle = [
  {"title": "Language", "icon": "icon_langouge.png"},
  {"title": "How To Subscribe", "icon": "icon_subs.png"},
  {"title": "Help Center", "icon": "icon_helpCnter.png"},
  {"title": "Contact Us", "icon": "icon_contact_us.png"},
  {"title": "Privacy Policy", "icon": "icon_privacy.png"},
  {"title": "Terms Conditions", "icon": "icon_terms.png"},
  {"title": "About InstaClass", "icon": "icon_about.png"},
  {"title": "Loyalty Program", "icon": "icon_crown.png"},
  {"title": "Sign Out", "icon": "icon_crown.png"},
];

class _UserProfilePageState extends State<UserProfilePage> {
  late final ScrollController _scrollController;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  double _imag = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _imag = _scrollController.offset * 0.5;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationVM = Provider.of<LocalizationViewModel>(context);

    final auth = Provider.of<AuthViewmodel>(context);
    return Scaffold(
      body: Container(
        color: Colors.grey[200],

        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300 + _imag,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19.0,
                  vertical: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 19.0,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/profile");
                          },
                          child: _buildHeader(),
                        ),
                        Divider(color: AppColors.Textgray, thickness: 1.5),
                        Expanded(
                          child: ListView.separated(
                            controller: _scrollController,

                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  if (index == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryDark,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 80,
                                          vertical: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            60,
                                          ),
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryDark,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MaterialButton(
                                                onPressed: () {
                                                  localizationVM.chingeLacale(
                                                    "en",
                                                  );
                                                },
                                                child: Text(" English"),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  localizationVM.chingeLacale(
                                                    "ar",
                                                  );
                                                },
                                                child: Text("Arabic"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        duration: const Duration(seconds: 4),
                                      ),
                                    );
                                  }
                                  if (index == 8) {
                                    await _databaseHelper.clearData();
                                    await auth.signout(context);
                                  }
                                  //
                                },
                                child: _buildListItem(
                                  iconTitle[index]["icon"],
                                  localizationVM.translate(
                                    iconTitle[index]["title"],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return const SizedBox(height: 25);
                            },
                            itemCount: iconTitle.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.primaryDark,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryLight,
          child: Icon(Icons.person, color: AppColors.backgroundEditText),
        ),
        const SizedBox(width: 20),
        const Text(
          "Aghar sukarieh",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildListItem(String image, String text) {
  return ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.primaryLight,
      child: Image.asset("images/icons/$image"),
    ),
    title: Text(text),
    trailing: const Icon(Icons.arrow_forward),
  );
}
