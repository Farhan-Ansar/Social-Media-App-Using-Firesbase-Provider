import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socialmedia_firebase/res/color.dart';
import 'package:socialmedia_firebase/view/dashboard/Profile/profile.dart';
import 'package:socialmedia_firebase/view/dashboard/User/user_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const Text("Home"),
      const Text("Chat"),
      const Text("Add"),
      const UserListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.chat,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.add,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.message,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.person,
          color: Colors.grey.shade100,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        controller: controller,
        context,
        screens: _buildScreen(),
        items: _navBarItem(),
        backgroundColor: AppColors.otpHintColor,
        navBarStyle: NavBarStyle.style14,
      ),
    );
  }
}
