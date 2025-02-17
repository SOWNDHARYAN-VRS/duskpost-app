import 'package:duskpost_app/pages/explore_page.dart';
import 'package:duskpost_app/pages/home_page.dart';
import 'package:duskpost_app/pages/notification_page.dart';
import 'package:duskpost_app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class DuskPostNavigationBar extends StatefulWidget {
  const DuskPostNavigationBar({super.key});

  @override
  State<DuskPostNavigationBar> createState() => _DuskPostNavigationBarState();
}

class _DuskPostNavigationBarState extends State<DuskPostNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface, // Match background color
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            backgroundColor: theme.colorScheme.surface, 
          height: 45, // Explicitly set height
          indicatorColor: Colors.transparent, // Hide indicator
          overlayColor: WidgetStateProperty.all(Colors.transparent), 
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 0), // Hide labels
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home,size: 28,),
              icon: Icon(Icons.home_outlined,size: 28,),
              label: '', // No label
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.explore,size: 28,),
              icon: Icon(Icons.explore_outlined,size: 28,),
              label: '', // No label
            ),
             NavigationDestination(
              selectedIcon: Icon(Icons.notifications,size: 28,),
              icon: Icon(Icons.notifications_outlined,size: 28,),
              label: '', // No label
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2,size: 28,),
              icon: Icon(Icons.person_2_outlined,size: 28,),
              label: '', // No label
            ),
          ],
        ),
      ),
      body: <Widget>[
        HomePage(),
        ExplorePage(),
        NotificationPage(),
        ProfilePage()
      ][currentPageIndex],
    );
  }
}
