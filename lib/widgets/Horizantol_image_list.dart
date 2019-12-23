import 'package:flutter/material.dart';
import 'package:movie_bucket/services/api_services.dart';

class HorizantolImageList extends StatelessWidget {
  final List<dynamic> list;
  final double height;
  HorizantolImageList({this.list, this.height = 300});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (_, index) {
          return _Tile(
            imagePath: list[index]['file_path'],
          );
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String imagePath;
  final String movieTitle;
  final int movieId;
  final double tileHeight = 120, tileWidth = 200;
  _Tile({this.imagePath, this.movieTitle, this.movieId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('tapped'),
      child: Container(
        height: (tileHeight),
        width: (tileWidth),
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: _image(),
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
                      size: ImageServices.POSTER_SIZE_HIGHEST),
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
