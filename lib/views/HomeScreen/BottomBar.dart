
import 'package:e_commerce_project/views/HomeScreen/CartPage.dart';
import 'package:flutter/material.dart';

import '../Profile/ProfilePage.dart';
import '../Profile/userdata.dart';
import '../Wishlist/Favorites.dart';
import 'homeScreen.dart';

class AnimatedBottomBar extends StatefulWidget {

  const AnimatedBottomBar({super.key});
  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  int? _currentPage;

  @override
  void initState() {
    _currentPage = 0;
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      // //   backgroundColor: Colors.deepPurple,
      // //   title: const Text("Home Screen",style: TextStyle(color: Colors.white),),
      // // ),
      backgroundColor: Colors.white,
      body: getPage(_currentPage),
      bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentPage,
          onChange: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }

  getPage(int? page) {
    switch (page) {
      case 0:
        return HomeScreen();
      case 1:
        return CartPage();
      case 2:
        return WishList();
      case 3:
        return ProfileSettingsPage();
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onChange;
  const AnimatedBottomNav({Key? key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.deepPurple,
      child: Container(
        height: kToolbarHeight,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () => onChange!(0),
                child: BottomNavItem(
                  icon: Icons.home,
                  title: "Home",
                  isActive: currentIndex == 0,
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () => onChange!(1),
                child: BottomNavItem(
                  icon: Icons.shopping_cart,
                  title: "Cart",
                  isActive: currentIndex == 1,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onChange!(2),
                child: BottomNavItem(
                  icon: Icons.favorite,
                  title: "Favorites",
                  isActive: currentIndex == 2,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onChange!(3),
                child: BottomNavItem(
                  icon: Icons.person_pin,
                  title: "Profile",
                  isActive: currentIndex == 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? title;
  const BottomNavItem(
      {Key? key,
        this.isActive = false,
        this.icon,
        this.activeColor,
        this.inactiveColor,
        this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(

      transitionBuilder: (child, animation) {
        return SlideTransition(

          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 200),
      child: isActive
          ? Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: activeColor ?? Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              width: 5.0,
              height: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor ?? Colors.red,
              ),
            ),
          ],
        ),
      )
          : Icon(
        icon,
        color: inactiveColor ?? Colors.deepPurple,
      ),
    );
  }
}