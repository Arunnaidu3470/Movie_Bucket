import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  AnimationController _animationController;
  bool isPlaying = false;
  int _selectedPage = 0;
  List<String> _pageTitles = <String>['Movies', 'TvShows'];

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles[_selectedPage]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return Search();
            }));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(index),
          children: <Widget>[
            Home(),
            TVshows(),
          ],
        ),
        bottomNavigationBar: _bottamAppBar());
  }

  Widget _bottamAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.blueGrey,
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onItemSelected,
          currentIndex: _selectedPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_movies),
              activeIcon: Icon(Icons.movie),
              title: Text('Movies'),
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              activeIcon: Icon(Icons.ondemand_video),
              title: Text('TV Shows'),
              backgroundColor: Colors.green,
            )
          ]),
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
