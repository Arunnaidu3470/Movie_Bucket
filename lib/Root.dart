import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket/pages/auth/signIn.dart';
import 'package:movie_bucket/services/auth/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'pages/Home.dart';
import 'pages/TVshows.dart';
import 'pages/Search.dart';

class RootPage extends StatefulWidget {
  final User currentUser;
  RootPage({this.currentUser});
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  AnimationController _animationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isPlaying = false;
  int _selectedPage = 0;
  List<String> _pageTitles = <String>['Movies', 'TvShows'];
  bool _darkMode = false;

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_pageTitles[_selectedPage]),
        actions: <Widget>[
          _profileAvatar(),
        ],
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
      bottomNavigationBar: _bottamAppBar(),
    );
  }

  Widget _profileAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          _settingModalBottomSheet(context);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(widget.currentUser.profileUrl)),
      ),
    );
  }

  _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    _modelTile(
                      text: 'Quick Settings',
                      fontSize: 15,
                      txtAlign: TextAlign.center,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              //todo:after implementing auth update a user profile image
                              widget.currentUser.profileUrl),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                '${widget.currentUser.name}'), //todo:after implementing auth update a user name
                            OutlineButton.icon(
                              icon: Icon(Icons.lock_outline),
                              label: Text('Sign Out'),
                              onPressed: () {
                                _handleSigOut();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                    _modelTile(
                      //todo:dark mode
                      trailing: Switch(
                        autofocus: true,
                        hoverColor: Colors.green,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (value) {
                          _darkMode = value;
                        },
                        value: _darkMode,
                      ),
                      text: 'Dark Mode',
                      highLightColor: Colors.green[100],
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                    _modelTile(
                      text: 'Settings',
                      icon: Icons.settings,
                      highLightColor: Colors.green[100],
                      onTap: () {
                        //todo:navigate to settings page
                      },
                    ),
                  ])));
        });
  }

  _handleSigOut() async {
    print('signing out');
    Navigator.of(context).pop();
    _scaffoldKey.currentState
        .showSnackBar((SnackBar(content: LinearProgressIndicator())));
    print('here 1');
    if (!await AuthServices.signOutWithGoogle()) return;
    print('here 2');
    _scaffoldKey.currentState.hideCurrentSnackBar();
    // Provider.of<User>(context, listen: false).dispose();
    print('sign out');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (cxt) => SignInPage())); //todo:sign out
  }

  Widget _modelTile(
      {String text,
      Widget title,
      Widget trailing,
      TextAlign txtAlign = TextAlign.start,
      Color highLightColor,
      IconData icon,
      Function onTap,
      double fontSize = 15,
      Color splashColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        onTap: onTap,
        splashColor: splashColor,
        highlightColor: highLightColor,
        child: ListTile(
            trailing: trailing,
            leading: icon == null ? null : Icon(icon),
            title: Text('$text',
                style: TextStyle(fontSize: fontSize), textAlign: txtAlign)),
      ),
    );
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
