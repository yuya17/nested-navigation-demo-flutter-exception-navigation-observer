import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TabItem {
  bookfeed,
  barcordreader,
  profile,
}

class TabHelper {
  static TabItem item({int index}) {
    switch (index) {
      case 0:
        return TabItem.bookfeed;
      case 1:
        return TabItem.barcordreader;
      case 2:
        return TabItem.profile;
    }
    return TabItem.bookfeed;
  }

  static String description(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.bookfeed:
        return 'BookFeed';
      case TabItem.barcordreader:
        return 'Barcord Reader';
      case TabItem.profile:
        return 'Profile';
    }
    return '';
  }
  static IconData icon(TabItem tabItem) {
    switch (tabItem){
      case TabItem.bookfeed:
        return FontAwesomeIcons.book;
      case TabItem.barcordreader:
        return FontAwesomeIcons.camera;
      case TabItem.profile:
        return FontAwesomeIcons.user;
    }
  }

  static MaterialColor color(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.bookfeed:
        return Colors.grey;
      case TabItem.barcordreader:
        return Colors.grey;
      case TabItem.profile:
        return Colors.grey;
    }
    return Colors.grey;
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.bookfeed),
        _buildItem(tabItem: TabItem.barcordreader),
        _buildItem(tabItem: TabItem.profile),
      ],
      onTap: (index) => onSelectTab(
        TabHelper.item(index: index),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {

    String text = TabHelper.description(tabItem);
    IconData icon = TabHelper.icon(tabItem);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? TabHelper.color(item) : Colors.grey;
  }
}