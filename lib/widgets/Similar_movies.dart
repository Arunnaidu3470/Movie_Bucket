import 'package:flutter/material.dart';
import 'package:movie_bucket/constants/constants.dart';
import 'package:movie_bucket/pages/Movie_details.dart';
import 'package:movie_bucket/services/api_services.dart';

@Deprecated('Use MovieTile()')
class SimilarMovies extends StatefulWidget {
  final List<dynamic> moviesList;
  SimilarMovies({this.moviesList});

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.moviesList.length,
        itemBuilder: (_, index) {
          return STile(
            index: index,
            imgPath: widget.moviesList[index]
                [SimilarMovieConstants.MOVIE_POSTER],
            title: widget.moviesList[index][SimilarMovieConstants.MOVIE_TITLE],
            id: widget.moviesList[index][SimilarMovieConstants.MOVIE_ID],
          );
        },
      ),
    );
  }
}

class STile extends StatefulWidget {
  final int index;
  final String imgPath;
  final String title;
  final int id;
  STile({this.index, this.imgPath, this.title, this.id});

  @override
  _STileState createState() => _STileState();
}

class _STileState extends State<STile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        width: 120,
        child: Card(
          elevation: 1,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <Widget>[
              _imageHead(),
              _titleBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleBottom() {
    return ListTile(
        title: Text(
      widget.title,
      style: TextStyle(fontSize: 12),
    ));
  }

  Widget _imageHead() {
    return SizedBox(
      height: 120,
      width: 120,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.network(
          ImageServices.getImageUrlOf(widget.imgPath,
              size: ImageServices.POSTER_SIZE_MEDIUMPLUS),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MovieDetailsPage(
        id: widget.id,
        title: widget.title,
      );
    }));
  }
}
