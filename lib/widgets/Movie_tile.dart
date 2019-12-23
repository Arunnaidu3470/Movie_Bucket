import 'package:flutter/material.dart';
import 'package:movie_bucket/constants/constants.dart';
import 'package:movie_bucket/pages/Movie_details.dart';
import 'package:movie_bucket/services/api_services.dart';

class MovieTile extends StatelessWidget {
  final List<dynamic> list;
  final Widget preWidget;
  MovieTile({this.list, this.preWidget});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: _assemble(),
    );
  }

  Widget _assemble() {
    int addPreTile = 0;
    if (preWidget != null) addPreTile = 1;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: list.length + addPreTile,
      itemBuilder: (context, index) {
        if (addPreTile != 0 && index == 0) return _pre();
        return _Tile(
          imagePath: list[index - addPreTile][MovieConstants.MOVIE_POSTER],
          movieTitle: list[index - addPreTile][MovieConstants.MOVIE_TITLE],
          movieId: list[index - addPreTile][MovieConstants.MOVIE_ID],
        );
      },
    );
  }

  Widget _pre() {
    return FittedBox(
        fit: BoxFit.cover,
        child: Container(
            height: 200, width: 120, child: Center(child: preWidget)));
  }
}

class _Tile extends StatelessWidget {
  final String imagePath;
  final String movieTitle;
  final int movieId;
  final double tileHeight = 200, tileWidth = 120;
  _Tile({this.imagePath, this.movieTitle, this.movieId});

  _nextPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MovieDetailsPage(
        id: movieId,
        title: movieTitle,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _nextPage(context),
      child: Container(
        height: (tileHeight),
        width: (tileWidth),
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _image(),
            _title(),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      height: (tileHeight - 30.0),
      width: (tileWidth),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 10,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: (imagePath != null)
              ? Image.network(
                  ImageServices.getImageUrlOf(imagePath,
                      size: ImageServices.POSTER_SIZE_MEDIUM),
                  fit: BoxFit.cover,
                )
              : Icon(Icons.local_movies),
        ),
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      width: tileHeight - 40,
      height: (tileHeight - (tileHeight - 20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          movieTitle,
          style: TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
