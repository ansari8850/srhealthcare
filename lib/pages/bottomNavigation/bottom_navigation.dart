import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottomNavigation_bloc.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottom_navigation_state.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottomnavigation_event.dart';
import 'package:srhealthcare/pages/feedPage/feed_page.dart';
import 'package:srhealthcare/pages/homePage/home_page.dart';
import 'package:srhealthcare/pages/searchPage/search_page.dart';
import 'package:srhealthcare/pages/settingPage/setting_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          int currentIndex =
              state is BottomNavigationInitial ? state.selectedIndex : 0;

          final List<Widget> _pages = [
            const HomePage(),
            const SearchPage(),
            const FeedPage(),
            const SettingPage(),
          ];

          return _pages[currentIndex];
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
                // Get the current selected index
                int currentIndex =
                    state is BottomNavigationInitial ? state.selectedIndex : 0;

                return BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex, // Highlight the selected tab
                  selectedItemColor: Colors.deepPurple,
                  unselectedItemColor: Colors.grey,
                  elevation: 0,
                  iconSize: 24,
                  onTap: (index) {
                    // Dispatch the event to change the selected index
                    context
                        .read<BottomNavigationBloc>()
                        .add(BottomNavigationIndexChanged(index));
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: _buildNavigationItemIcon(context, currentIndex, 0,
                          "assets/bottomnav/home.png"),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: _buildNavigationItemIcon(context, currentIndex, 1,
                          "assets/bottomnav/search.png"),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: _buildNavigationItemIcon(context, currentIndex, 2,
                          "assets/bottomnav/feed.png"),
                      label: "Feed",
                    ),
                    BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                              color: currentIndex == 3
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Icon(
                            Icons.person,
                            color: currentIndex == 3
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                        ],
                      ),
                      label: "Profile",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItemIcon(
      BuildContext context, int currentIndex, int itemIndex, String assetPath) {
    return Column(
      children: [
        Container(
          height: 3,
          width: 30,
          decoration: BoxDecoration(
            color: currentIndex == itemIndex
                ? Colors.deepPurple
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          assetPath,
          width: 24,
          height: 24,
          color: currentIndex == itemIndex ? Colors.deepPurple : Colors.grey,
        ),
      ],
    );
  }
}
