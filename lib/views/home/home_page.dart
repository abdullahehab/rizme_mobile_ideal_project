import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/home_app_bar.dart';
import 'views/home_view.dart';
import 'widgets/nav_drawer.dart';
import 'widgets/profile_drawer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const NavDrawer(),
      appBar:const HomeAppBar(),
      endDrawer: const ProfileDrawer(),
      body: const HomeView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _onBottomNavItemTap(index, context);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedItemIndex,
        items: _bottomBarItems(_selectedItemIndex),
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withAlpha(150),
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  void _onBottomNavItemTap(int index, BuildContext context) {
    if (index == 2) {
      // Navigator.of(context).pushNamed(CreatePostScreen.routeName);
    } else {
      setState(() {
        _selectedItemIndex = index;
      });
    }
  }

  List<BottomNavigationBarItem> _bottomBarItems(int selectedIndex) {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
          size: 24,
        ),
        backgroundColor: Colors.white,
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          selectedIndex == 1
              ? Icons.compass_calibration
              : Icons.compass_calibration_outlined,
          size: 24,
        ),
        backgroundColor: Colors.white,
        label: "Unknown",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.add,
          size: 24,
        ),
        label: "Create",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          selectedIndex == 3 ? Icons.chat_bubble : Icons.chat_bubble_outline,
          size: 24,
        ),
        backgroundColor: Colors.white,
        label: "Chats",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          selectedIndex == 4 ? Icons.notifications : Icons.notifications_none,
          size: 24,
        ),
        backgroundColor: Colors.white,
        label: "Notifications",
      ),
    ];
  }
}