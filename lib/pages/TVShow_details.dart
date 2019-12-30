import 'dart:ui';
import 'package:flutter/material.dart';

import '../widgets/ProductionList.dart';
import '../services/Tv_apiServices.dart';
import '../constants/constants.dart';
import '../services/api_services.dart';
import '../widgets/Cast_Details.dart';
import '../widgets/Movie_tile.dart';

class TVShowDetailsPage extends StatefulWidget {
  final String title;
  final int showId;
  TVShowDetailsPage({this.showId, this.title});

  @override
  _TVShowDetailsPageState createState() => _TVShowDetailsPageState();
}

class _TVShowDetailsPageState extends State<TVShowDetailsPage> {
  bool _showMoreBio = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: TVServices.getShowDetailsById(widget.showId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                stretch: true,
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height / 2,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true, background: _background(snapshot)),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _storyLine(snapshot.data[TVShowConstants.OVERVIEW]),
                  Divider(),
                  CastDetails(
                    castList: snapshot.data['created_by'],
                    widgetTitle: 'Created By',
                    icon: Icons.people,
                  ),
                  Divider(),
                  ProductionList(
                    list: snapshot.data['production_companies'],
                  ),
                  Divider(),
                  _seasons(seasonList: snapshot.data['seasons']),
                  SizedBox(
                    height: 40,
                  ),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _imageBackground(BuildContext context, {String backgroundPath}) {
    if (backgroundPath == null) return Text('No Image');
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: ClipRRect(
          child: Image.network(
            ImageServices.getImageUrlOf(backgroundPath,
                size: ImageServices.BACKDROP_SIZE_HIGHEST),
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _background(AsyncSnapshot snapshot) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: _imageBackground(context,
              backgroundPath: snapshot.data[TVShowConstants.BACK_DROP]),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.white.withOpacity(0.95)
                ])),
          ),
        ),
        Positioned(left: 20, bottom: 50, child: _header(snapshot)),
      ],
    );
  }

  Widget _header(AsyncSnapshot snapshot) {
    return GestureDetector(
      onTap: () => print('tapped'),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.assetNetwork(
                  image: ImageServices.getImageUrlOf(
                      snapshot.data[TVShowConstants.POSTER_PATH],
                      size: ImageServices.POSTER_SIZE_LOW),
                  placeholder: 'assets/loading.png',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 110,
                )),
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    textWidthBasis: TextWidthBasis.parent,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  _popularity(snapshot.data[TVShowConstants.POPULARITY]),
                  _year(snapshot.data[TVShowConstants.AIR_DATE]),
                  _rating(snapshot.data[TVShowConstants.RATING]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularity(double popularity) {
    int temp = (popularity * 100.0).round();
    popularity = temp / 100;
    Color color = Colors.green[100];
    return Row(
      children: <Widget>[
        Icon(
          Icons.trending_up,
          color: color,
        ),
        Text(' $popularity %', style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _year(String duriation) {
    String temp = duriation.toString().substring(0, 4);
    return Row(
      children: <Widget>[
        Icon(
          Icons.date_range,
          color: Colors.green[100],
        ),
        Text(temp, style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _rating(double rating) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow[200],
        ),
        Text('$rating', style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _storyLine(String storyLine) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.assignment,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Story Line',
                maxLines: 3,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
                textWidthBasis: TextWidthBasis.parent,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
            height:
                (!_showMoreBio ? 100 : storyLine.length.toDouble() / (5 / 2)),
            width: MediaQuery.of(context).size.width,
            child: Text(
              storyLine,
              overflow: TextOverflow.ellipsis,
              maxLines: (!_showMoreBio) ? 5 : 500,
            ),
          ),
          _readMore(),
        ],
      ),
    );
  }

  _readMore() {
    return GestureDetector(
      child: Text(
        (!_showMoreBio) ? 'Read less' : '..Read more',
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.green[400], fontSize: 16),
      ),
      onTap: () {
        setState(() {
          _showMoreBio = !_showMoreBio;
        });
      },
    );
  }

  Widget _geners({List<dynamic> generData}) {
    generData.map((index) {
      return Chip(
        label: Text(index['name']),
      );
    }).toList();

    return Wrap(
      spacing: 0.5,
      children: generData.map((index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            label: Text(index['name']),
          ),
        );
      }).toList(),
    );
  }

  Widget _releasedDate({String date}) {
    return Text(
      date,
      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
    );
  }

  Widget _cast() {
    return FutureBuilder(
        future: MovieServices.getMovieCastDetails(widget.showId.toString()),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Container(
            child: CastDetails(
              castList: snapshot.data,
            ),
          );
        });
  }

  Widget _similarMovies() {
    return FutureBuilder(
        future: MovieServices.getSimilarMovies(widget.showId.toString()),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data.isEmpty)
            return Center(
              child: Text('We were unable to find Similar Movies'),
            );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.play_circle_filled,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      ' Similar Movies',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: MovieTile(
                  list: snapshot.data,
                ),
              ),
            ],
          );
        });
  }

  Widget _seasons({List<dynamic> seasonList}) {
    return Column(
      children: seasonList.map((item) {
        return _expansionTile(
            title: item['name'],
            imgPath: item['poster_path'],
            overview: item['overview'],
            episodecount: item['episode_count']);
      }).toList(),
    );
  }

  Widget _expansionTile(
      {String title, String imgPath, String overview, int episodecount}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 2, right: 2),
      child: ExpansionTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage(
            width: 50,
            height: 200,
            image: NetworkImage(
              ImageServices.getImageUrlOf(imgPath,
                  size: ImageServices.POSTER_SIZE_LOWEST),
            ),
            placeholder: AssetImage('assets/loading.png'),
            fit: BoxFit.cover,
          ),
        ),
        title: Text('$title'),
        subtitle: Text('Total Episodes $episodecount'),
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              width: 300,
              child: Text(overview != null ? '$overview' : 'No info')),
          OutlineButton.icon(
            icon: Icon(Icons.open_in_new),
            label: Text('More Info'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
