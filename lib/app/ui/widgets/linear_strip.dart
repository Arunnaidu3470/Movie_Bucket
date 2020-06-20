// This file contains a Widget which shows movies in a horizantal view
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_bucket/models/models.dart';
import '../../../utils/utils.dart' as utils;

class LinearStrip extends StatelessWidget {
  final List<MovieModel> movieList;
  final Function(int index, int id, String heroTag) onSelect;
  final Function(int index, int id, String heroTag) onLongPress;
  final Function(int index, int id, String heroTag) onDoubleTap;
  final Tween<Offset> _tweenAnimation =
      Tween<Offset>(begin: Offset(-20, 0), end: Offset(0, 0));

  LinearStrip({
    Key key,
    @required this.movieList,
    this.onSelect,
    this.onLongPress,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        cacheExtent: 6,
        itemCount: movieList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (cxt, index) {
          return GestureDetector(
            onDoubleTap: () {
              if (onDoubleTap != null) {
                onDoubleTap(
                  index,
                  movieList[index].id,
                  'striptag+$index+${movieList[index].id}',
                );
              }
            },
            onLongPress: () {
              if (onLongPress != null) {
                onLongPress(
                  index,
                  movieList[index].id,
                  'striptag+$index+${movieList[index].id}',
                );
              }
            },
            onTap: () {
              if (onSelect != null) {
                onSelect(
                  index,
                  movieList[index].id,
                  'striptag+$index+${movieList[index].id}',
                );
              }
            },
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 250),
              curve: Curves.bounceInOut,
              tween: _tweenAnimation,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: value,
                  child: child,
                );
              },
              child: Hero(
                tag: 'striptag+$index+${movieList[index].id}',
                child: StripItem(
                  id: movieList[index].id,
                  title: movieList[index].title,
                  rating: movieList[index].voteAverage,
                  posterUrl: movieList[index].posterPath,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StripItem extends StatelessWidget {
  final int id;
  final String title;
  final double rating;
  final String posterUrl;

  const StripItem({
    Key key,
    this.id,
    this.title,
    this.rating,
    this.posterUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: _networkImage(),
          ),
          SizedBox(height: 5),
          _starRow(),
          SizedBox(height: 5),
          Text(
            title ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget _starRow() {
    int totalStars = (((rating ?? 0) / 10) * 5).toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(totalStars, (index) => index)
          .map<Icon>(
              (e) => Icon(Icons.star, color: Colors.yellow[800], size: 12.5))
          .toList(),
    );
  }

  Widget _networkImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: NetworkImage(
          utils.getimageUrl(
            posterUrl,
            imageSize: utils.ImageSizes.POSTER_SIZE_MEDIUMPLUSw342,
          ),
        ),
        fit: BoxFit.cover,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            // loading
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Center(
                child: Text(
                  'Movie\n Bucket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          // loaded
          return child;
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          double percent = (loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes) *
              10;
          return Center(
              child: CircularProgressIndicator(
            value: percent,
            backgroundColor: Colors.white,
          ));
        },
        errorBuilder: (context, error, stackTrace) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(
              child: Text(
                'Movie\n Bucket',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
