import 'package:flutter/material.dart';

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
              return Carousel(snapshot: snapshot.data);
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
              return Carousel(
                  snapshot: snapshot.data,
                  height: 150,
                  viewportFraction: 0.3,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  scrollPhysics: BouncingScrollPhysics(),
                  pre: _text('IN THEATORS'),
                  initialPage: 1,
                  infiniteScroll: false);
            },
          ),
          Divider(),
          FutureBuilder(
            future: MovieServices.getMoviesUpComing(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Carousel(
                  snapshot: snapshot.data,
                  height: 150,
                  viewportFraction: 0.3,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  scrollPhysics: BouncingScrollPhysics(),
                  pre: _text('UP COMING'),
                  initialPage: 1,
                  infiniteScroll: false);
            },
          ),
          Divider(),
          FutureBuilder(
            future: MovieServices.getMoviesTopRated(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Carousel(
                  snapshot: snapshot.data,
                  height: 150,
                  viewportFraction: 0.3,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  scrollPhysics: BouncingScrollPhysics(),
                  pre: _text('TOP RATED'),
                  initialPage: 1,
                  infiniteScroll: false);
            },
          ),
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
