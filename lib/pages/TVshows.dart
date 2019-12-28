import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widgets/Carousel_Item.dart';
import '../constants/constants.dart';
import '../services/Tv_apiServices.dart';
import '../widgets/TVshow_tile.dart';

class TVshows extends StatefulWidget {
  @override
  _TVshowsState createState() => _TVshowsState();
}

class _TVshowsState extends State<TVshows> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV shows'),
      ),
      body: _assemble(),
    );
  }

  Widget _assemble() {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Airing Today',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25),
            ),
          ),
          _airingToday(),
          Divider(),
          _popularShows(),
          Divider(),
          _onGoing(),
          Divider(),
          _topRated(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _popularShows() {
    return FutureBuilder(
      future: TVServices.getPopularShows(page: 1),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        List<dynamic> results = snapshot.data['results'];
        return TVShowTile(
          preWidget: Text(
            'POPULAR',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          list: results,
        );
      },
    );
  }

  Widget _airingToday() {
    return FutureBuilder(
      future: TVServices.getAiringToday(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        List<dynamic> list = snapshot.data;
        return CarouselSlider(
          autoPlay: true,
          pauseAutoPlayOnTouch: Duration(seconds: 4),
          enlargeCenterPage: true,
          items: list.map((item) {
            return CarouselItem(
              backgroundImage: item[TVShowConstants.BACK_DROP],
              context: context,
              forgroundImage: item[TVShowConstants.POSTER_PATH],
              id: item[TVShowConstants.ID],
              itemType: CarouselItemType.tvShow,
              popularity: item[TVShowConstants.POPULARITY],
              title: item[TVShowConstants.TITLE],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _onGoing() {
    return FutureBuilder(
      future: TVServices.getOnGoingShow(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        return TVShowTile(
          preWidget: Text(
            'ONGOING',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          list: snapshot.data,
        );
      },
    );
  }

  Widget _topRated() {
    return FutureBuilder(
      future: TVServices.getTopRated(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        return TVShowTile(
          preWidget: Text(
            'TOP RATED',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          list: snapshot.data,
        );
      },
    );
  }
}
