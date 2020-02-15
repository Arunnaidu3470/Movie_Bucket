// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/Tv_apiServices.dart';
import '../widgets/TVshow_tile.dart';
import '../constants/constants.dart';
import '../services/Movie_apiServices.dart';
import '../services/Image_services.dart';
import '../widgets/Cast_Details.dart';
import '../widgets/Movie_tile.dart';
import '../widgets/VideoPlayer.dart';

class MovieDetailsPage extends StatefulWidget {
  final String title;
  final int id;
  MovieDetailsPage({this.id, this.title});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MovieServices.getMovieById(id: widget.id.toString()),
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
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                        widget.title == null ? "Movie Details" : widget.title),
                    background: _imageBackground(context,
                        backgroundPath: snapshot
                            .data[MovieConstants.MOVIE_BACK_DROP_POSTER])),
              ),
              SliverToBoxAdapter(
                child: _futureBuilder(
                    MovieServices.getMovieById(id: widget.id.toString())),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Divider(),
                  _trailer(),
                  Divider(),
                  _cast(),
                  Divider(),
                  _similarMovies(),
                  Divider(),
                  _similarTVShows(),
                  Divider(),
                ], addAutomaticKeepAlives: true),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 150,
                    child: Center(child: Text('Thats all for now'))),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _futureBuilder(Future future, {BuildContext context}) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return _assemble(context, data: snapshot.data);
      },
    );
  }

  Widget _assemble(BuildContext context, {dynamic data}) {
    return Column(
      children: <Widget>[
        _geners(generData: data[MovieConstants.MOVIE_GENERS]),
        _releasedDate(date: data[MovieConstants.MOVIE_RELEASE_DATE]),
        Divider(),
        _plot(plot: data[MovieConstants.MOVIE_PLOT]),
      ],
    );
  }

  Widget _imageBackground(BuildContext context, {String backgroundPath}) {
    if (backgroundPath == null) return Text('No Image');
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: ClipRRect(
          child: Image(
            image: NetworkImage(ImageServices.getImageUrlOf(backgroundPath,
                size: ImageServices.BACKDROP_SIZE_HIGHEST)),
            fit: BoxFit.cover,
            // placeholder: (context, url) =>
            //     Center(child: CircularProgressIndicator()),
          ),
        ));
  }

  Widget _plot({String plot}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.assignment,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                ' Story Line',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(plot),
        ],
      ),
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

  Widget _trailer() {
    return FutureBuilder(
      future: MovieServices.getMovieYtTrailerIdById(widget.id.toString()),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LinearProgressIndicator(
            backgroundColor: Colors.green[100],
          );
        if (!snapshot.hasData) Center(child: Text('Loading Trailer'));
        if (snapshot.data == null)
          Center(
            child: Text('No'),
          );
        if (snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_movies,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      ' Trailer',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: VideoPlayer(
                    videoid: snapshot.data,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text('Trailer will be added soon'));
      },
    );
  }

  Widget _cast() {
    return FutureBuilder(
        future: MovieServices.getMovieCastDetails(widget.id.toString()),
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
        future: MovieServices.getSimilarMovies(widget.id.toString()),
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

  Widget _similarTVShows() {
    return FutureBuilder(
        future: TVServices.getSimilarShowsById(widget.id),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data.isEmpty)
            return Center(
              child: Text('We were unable to find Similar TV Shows'),
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
                      ' Similar TV Shows',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 200,
                  child: TVShowTile(
                    list: snapshot.data,
                  )),
            ],
          );
        });
  }
}
