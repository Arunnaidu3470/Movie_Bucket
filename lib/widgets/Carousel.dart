import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'PosterTile.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> snapshot;
  final num viewportFraction;
  final double height;
  final bool enlargeCenterPage;
  final bool autoPlay;
  final ScrollPhysics scrollPhysics;
  final bool infiniteScroll;
  final int initialPage;
  final Widget pre;
  final bool disableRating;
  Carousel({
    this.snapshot,
    this.viewportFraction = 0.8,
    this.height,
    this.enlargeCenterPage = true,
    this.autoPlay = true,
    this.infiniteScroll = true,
    this.initialPage = 0,
    this.pre,
    this.scrollPhysics,
    this.disableRating = false,
  });

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      initialPage: widget.initialPage,
      autoPlay: widget.autoPlay,
      enlargeCenterPage: widget.enlargeCenterPage,
      pauseAutoPlayOnTouch: Duration(seconds: 4),
      enableInfiniteScroll: widget.infiniteScroll,
      height: widget.height,
      scrollPhysics: widget.scrollPhysics,
      viewportFraction: widget.viewportFraction,
      items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((index) {
        return Builder(
          builder: (BuildContext context) {
            if (index == 0 && widget.pre != null) return widget.pre;
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: PosterTile(
                name: widget.snapshot[index][MovieConstants.MOVIE_TITLE],
                posterPath: widget.snapshot[index][MovieConstants.MOVIE_POSTER],
                // plot: snapshot[index][MovieConstants.MOVIE_PLOT],
                userRating: (widget.disableRating)
                    ? ""
                    : widget.snapshot[index][MovieConstants.MOVIE_RATING]
                        .toString(),
                index: index,
                id: widget.snapshot[index][MovieConstants.MOVIE_ID],
                diasbleRating: widget.disableRating,
                // releasedOn: snapshot[index][MovieConstants.MOVIE_RELEASE_DATE],
              ),
            );
          },
        );
      }).toList(),
    );
    ;
  }
}
