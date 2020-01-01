import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'pages/Home.dart';
import 'pages/TVshows.dart';
import 'pages/Search.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  int _selectedPage = 0;
  List<String> _pageTitles = <String>['Movies', 'TvShows', 'Search'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedPage]),
      ),
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => _onPageChanged(index),
        children: <Widget>[
          Home(),
          TVshows(),
          Search(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        showElevation: false,
        animationDuration: Duration(milliseconds: 500),
        iconSize: 30,
        selectedIndex: _selectedPage,
        onItemSelected: _onItemSelected,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.local_movies),
            title: Text('Movies'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.tv),
            title: Text('TV Shows'),
            activeColor: Colors.purpleAccent,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }

  _onItemSelected(int index) {
    if (index == _selectedPage) return;
    setState(() {
      _selectedPage = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  _onPageChanged(int index) {
    if (index == _selectedPage) return;
    setState(() {
      _selectedPage = index;
    });
  }
}
