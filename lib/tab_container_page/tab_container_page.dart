import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../now_playing/now_playing_page.dart';
import '../top_rated/top_rated_movie_page.dart';

class TabContainerPage extends StatefulWidget {


  const TabContainerPage( {super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabContainerPageState();
  }
}

class _TabContainerPageState extends State<TabContainerPage> {
  late List<Widget> _pages;


  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  _TabContainerPageState() {
    _pages = <Widget>[
     const NowPlayingMoviePage(),
     const  TopRatedMoviePage(),

    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.yellow,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,

        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.movie_creation_outlined),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        title: "Now Playing",
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.star_border),
        title: "Top Rated",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),

    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

}
