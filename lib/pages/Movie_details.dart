import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket/constants/constants.dart';
import 'package:movie_bucket/services/api_services.dart';
import 'package:movie_bucket/widgets/Cast_Details.dart';
import 'package:movie_bucket/widgets/Similar_movies.dart';
import 'package:movie_bucket/widgets/VideoPlayer.dart';

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
        _geners(generData: data[MovieConstants.Movie_GENERS]),
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
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: APIServices.getImageUrlOfMovie(backgroundPath),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
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
          print(snapshot.data.isEmpty);
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
                child: SimilarMovies(
                  moviesList: snapshot.data,
                ),
              ),
            ],
          );
        });
  }
}
