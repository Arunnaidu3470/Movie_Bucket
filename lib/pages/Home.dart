import 'package:flutter/material.dart';
import '../widgets/Movie_tile.dart';

import '../services/api_services.dart';
import '../widgets/Carousel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Bucket'),
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[_assemble()],
        ),
      ),
    );
  }

  Container _assemble() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: APIServices.getLatestMovies(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Carousel(
                snapshot: snapshot.data,
                disableRating: false,
              );
            },
          ),
          Divider(),
          FutureBuilder(
              future: MovieServices.getMoviesNowPlaying(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data,
                  preWidget: _text('IN THEATORS'),
                );
              }),
          Divider(),
          FutureBuilder(
              future: MovieServices.getMoviesUpComing(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data,
                  preWidget: _text('UP COMING'),
                );
              }),
          Divider(),
          FutureBuilder(
              future: MovieServices.getMoviesTopRated(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data,
                  preWidget: _text('TOP RATED'),
                );
              }),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    ));
  }
}
