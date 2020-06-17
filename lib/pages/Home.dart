import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket/constants/Keys.dart';

import '../constants/constants.dart';
import '../widgets/Carousel_Item.dart';
import '../widgets/Movie_tile.dart';
import '../services/Movie_apiServices.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  ApiKeys keys;
  TMDB _tmdb;

  _HomeState() {
    keys = ApiKeys(Keys.API_V3, Keys.API_V4);
    _tmdb = TMDB(keys);
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[_assemble()],
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
            future: _tmdb.v3.movies.getUpcoming(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              List<dynamic> list = snapshot.data['results'];
              return CarouselSlider(
                autoPlay: true,
                pauseAutoPlayOnTouch: Duration(seconds: 4),
                enlargeCenterPage: true,
                items: list.map((item) {
                  return CarouselItem(
                    context: context,
                    id: item[MovieConstants.MOVIE_ID],
                    backgroundImage:
                        item[MovieConstants.MOVIE_BACK_DROP_POSTER],
                    forgroundImage: item[MovieConstants.MOVIE_POSTER],
                    itemType: CarouselItemType.movie,
                    title: item[MovieConstants.MOVIE_TITLE],
                    popularity: item[MovieConstants.POPULARITY],
                  );
                }).toList(),
              );
            },
          ),
          Divider(),
          FutureBuilder(
              future: _tmdb.v3.movies.getNowPlaying(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data['results'],
                  preWidget: _text('IN THEATORS'),
                );
              }),
          Divider(),
          FutureBuilder(
              future: _tmdb.v3.movies.getUpcoming(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data['results'],
                  preWidget: _text('UP COMING'),
                );
              }),
          Divider(),
          FutureBuilder(
              future: _tmdb.v3.movies.getTopRated(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data['results'],
                  preWidget: _text('TOP RATED'),
                );
              }),
          Divider(),
          FutureBuilder(
              future: _tmdb.v3.discover.getMovies(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return MovieTile(
                  list: snapshot.data['results'],
                  preWidget: _text('SOMTHING COOL'),
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
