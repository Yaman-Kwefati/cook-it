import 'package:cook_it/screens_components/favorite_screen_body.dart';
import 'package:cook_it/screens_components/home_screen_body.dart';
import 'package:cook_it/screens_components/home_screen_floation_action_button.dart';
import 'package:cook_it/screens_components/user_screen_body.dart';
import 'package:cook_it/screens_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatefulWidget {
  static final id = "main_screen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:
            selectedIndex == 0 ? HomeScreenFloationAction() : null,
        appBar: AppBar(
          title: Text(
            "CookIt",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shadowColor: Colors.white,
          backgroundColor: Color(0xFFFFFFFF),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            HomeScreenBody(),
            FavoriteSreenBody(),
            UserScreenBody(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: kPrimaryColor,
          waterDropColor: Colors.white,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: Icons.favorite_rounded,
              outlinedIcon: Icons.favorite_border_rounded,
            ),
            BarItem(
              filledIcon: Icons.account_circle_rounded,
              outlinedIcon: Icons.account_circle_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
