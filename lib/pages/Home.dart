import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/Carousel_Item.dart';
import '../widgets/Movie_tile.dart';
import '../services/api_services.dart';

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
              if (!snapshot.hasData) return Container();
              List<dynamic> list = snapshot.data;
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
