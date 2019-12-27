import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../pages/TVShow_details.dart';
import '../constants/constants.dart';
import '../services/Tv_apiServices.dart';
import '../services/api_services.dart';
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
            return _carousel(item, context);
          }).toList(),
        );
      },
    );
  }

  Widget _carousel(item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TVShowDetailsPage(
            showId: item[TVShowConstants.ID],
            title: item[TVShowConstants.TITLE],
          );
        }));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ImageServices.getImageUrlOf(item[TVShowConstants.BACK_DROP],
                        size: ImageServices.BACKDROP_SIZE_HIGHEST),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.black.withOpacity(1),
                        ]),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 4,
                child: Container(
                  height: 150,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(ImageServices.getImageUrlOf(
                            item[TVShowConstants.POSTER_PATH],
                            size: ImageServices.POSTER_SIZE_MEDIUM)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              item[TVShowConstants.TITLE],
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              textWidthBasis: TextWidthBasis.parent,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.poll,
                                  color: Colors.yellow[100],
                                ),
                                Text(
                                  item[TVShowConstants.POPULARITY].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularAiringToday() {
    return FutureBuilder(
      future: TVServices.getAiringToday(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        return TVShowTile(
          preWidget: Text(
            'AIRING TODAY',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          list: snapshot.data,
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
