import 'dart:ui';
import 'package:flutter/material.dart';

import '../widgets/Horizantol_image_list.dart';
import '../constants/constants.dart';
import '../services/People_services.dart';
import '../services/Image_services.dart';
import '../widgets/Movie_tile.dart';

class PeopleDetailPage extends StatefulWidget {
  final int castId;
  final String castName;
  PeopleDetailPage({this.castId, this.castName});

  @override
  _PeopleDetailPageState createState() => _PeopleDetailPageState();
}

class _PeopleDetailPageState extends State<PeopleDetailPage> {
  bool _showMoreBio = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PeopleServices.getPeopleDetailsById(widget.castId),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                  stretch: true,
                  expandedHeight: 400,
                  backgroundColor: Colors.black.withOpacity(0.2),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _background(snapshot),
                  )),
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  _bio(snapshot.data[PeopleConstant.BIOGRAPHY]),
                  Divider(),
                  _actedMoviesCredits(),
                  Divider(),
                  _imageGrid(),
                  SizedBox(
                    height: 50,
                  ),
                ], addAutomaticKeepAlives: true),
              ),
            ],
          );
        },
      ),
    );
  }

  Stack _background(AsyncSnapshot snapshot) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.network(
            ImageServices.getImageUrlOf(
                snapshot.data[PeopleConstant.PROFILE_PATH],
                size: ImageServices.POSTER_SIZE_MEDIUM),
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.white])),
          ),
        ),
        Positioned(left: 20, bottom: 50, child: _header(snapshot)),
      ],
    );
  }

  Widget _header(AsyncSnapshot snapshot) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: GestureDetector(
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
                        snapshot.data[PeopleConstant.PROFILE_PATH],
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
                      widget.castName,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textWidthBasis: TextWidthBasis.parent,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    _knownFor(
                        snapshot.data[PeopleConstant.KNOWN_FOR_DEPARTMENT]),
                    _placeOfBirth(snapshot.data[PeopleConstant.PLACE_OF_BIRTH]),
                    _popularity(snapshot.data[PeopleConstant.POPULARITY]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bio(String bio) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.assignment,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'BIO',
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
            duration: Duration(milliseconds: 500),
            height: (!_showMoreBio ? 100 : bio.length.toDouble() / (5 / 2)),
            width: MediaQuery.of(context).size.width,
            child: Text(
              bio,
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
        (!_showMoreBio) ? '..Read more' : 'Read less',
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

  Widget _knownFor(String knownFor) {
    return Text(knownFor, style: TextStyle(color: Colors.white70));
  }

  Widget _gender(int gender) {
    return Text(
      gender == 0 ? 'Male' : 'Female',
      style: TextStyle(color: Colors.white70),
    );
  }

  Widget _placeOfBirth(String placeOfBirth) {
    if (placeOfBirth == null) return SizedBox();
    return Text(placeOfBirth,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white70));
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

  Widget _actedMoviesCredits() {
    return FutureBuilder(
      future: PeopleServices.getPeopleMovieCreditsById(widget.castId),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.local_movies,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Also In',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            MovieTile(
              list: snapshot.data,
            ),
          ],
        );
      },
    );
  }

  Widget _imageGrid() {
    return FutureBuilder(
      future: PeopleServices.getPeopleImagesById(widget.castId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.photo_library,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Images',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                ],
              ),
            ),
            HorizantolImageList(
              list: snapshot.data,
            ),
          ],
        );
      },
    );
  }
}
