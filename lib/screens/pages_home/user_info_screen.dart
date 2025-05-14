import 'package:flutter/material.dart';
import 'package:insta_class/utils/app_colors.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/data_from_firestore_view_model.dart';
import 'package:insta_class/view_models/database_mangers.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:provider/provider.dart';


class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  late String userId;
  late AuthViewmodel authViewModel;
  late DataFromFirestoreViewModel dataViewModel;
  List<Map<String, dynamic>> info = [];
  bool isEdit = false;
  bool _isLoading = true;
  DatabaseMangers databaseMangers = DatabaseMangers();

  final TextEditingController _userNameController = TextEditingController(
    text: "Aghar",
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dataViewModel = Provider.of<DataFromFirestoreViewModel>(context);
    authViewModel = Provider.of<AuthViewmodel>(context);
    if (_isLoading) {
      getedata();
    }
  }

  void getedata() async {
    userId = await authViewModel.getuid();

    if (info.isEmpty || userId != info[0]["id"]) {
      int result = await databaseMangers.fetchDataAndStore(context, userId);
      if (result > 0) {
        await getDatabase();
      }
    } else {
      await getDatabase();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getDatabase() async {
    info = await databaseMangers.getData(userId, context);
    print(
      "==========================================================================================================================================================$info",
    );
  }

  @override
  Widget build(BuildContext context) {
    LocalizationViewModel localizationVM = Provider.of<LocalizationViewModel>(
      context,
    );
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Container(
        color: AppColors.primaryDark,
        child: Stack(
          children: [
            Positioned.fill(
              top: 100,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localizationVM.translate(info[0]["name"]),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(localizationVM.translate("UserName")),
                          subtitle:
                              isEdit
                                  ? TextField(
                                    cursorColor: AppColors.primaryDark,
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                      hintText: localizationVM.translate(
                                        info[0]["name"],
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                    ),
                                  )
                                  : Text(_userNameController.text),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                isEdit = !isEdit;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            localizationVM.translate("Email Address"),
                          ),
                          subtitle: Text(info[0]["email"]),
                          trailing: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        ListTile(
                          title: Text(localizationVM.translate("Number Phone")),
                          subtitle: Text(info[0]["phone"]),
                          trailing: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        ListTile(
                          title: Text(localizationVM.translate("Password")),
                          subtitle: const Text("********"),
                          trailing: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.39,
                            vertical: 15,
                          ),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: AppColors.primaryDark,
                          onPressed: () {
                            databaseMangers.updateData(
                              userId,
                              _userNameController.text,
                            );
                            setState(() {
                              isEdit = false;
                            });
                          },
                          child: Text(
                            localizationVM.translate("Save"),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.39,
                            vertical: 15,
                          ),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: AppColors.primaryDark,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            localizationVM.translate("Back"),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: islandscape ? heightScreen / 7 : heightScreen / 12,
                  left: islandscape ? widthScreen / 2.40 : widthScreen / 3 + 20,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    child: Image.asset(
                      "images/moh.jpeg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: islandscape ? heightScreen / 3.5 : heightScreen / 6.4,
                  left: islandscape ? widthScreen / 2 : widthScreen / 2 + 20,
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.primaryDark,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          content: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "images/icons/icon_camera.png",
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "images/icons/icon_gallery.png",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    },
                    icon: Image.asset(
                      "images/icons/icon_edit_imagee.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
