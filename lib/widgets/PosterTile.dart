import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket/pages/Movie_details.dart';
import 'package:movie_bucket/services/api_services.dart';

class PosterTile extends StatefulWidget {
  final String name;
  final String plot;
  final String posterPath;
  final String userRating;
  final releasedOn;
  final Function onTap;
  final int index;
  final int id;
  final bool diasbleRating;
  PosterTile({
    this.name,
    this.plot,
    this.posterPath,
    this.userRating,
    this.onTap,
    this.index,
    this.releasedOn,
    this.id,
    this.diasbleRating = false,
  });

  @override
  _PosterTileState createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Stack(
          children: <Widget>[
            _image(context),
            Align(alignment: Alignment.bottomCenter, child: _bottom())
          ],
        ),
      ),
    );
  }

  onTap() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MovieDetailsPage(
        id: widget.id,
        title: widget.name,
      );
    }));
  }

  Widget _bottom() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Wrap(
          verticalDirection: VerticalDirection.up,
          direction: Axis.horizontal,
          children: <Widget>[
            _title(),
            if (!widget.diasbleRating) _rating(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Text(
        widget.name,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _rating() {
    if (widget.userRating.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.amber[500],
            size: 10,
          ),
          Text(widget.userRating.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.amber[100]))
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: (widget.posterPath != null)
              ? CachedNetworkImage(
                  filterQuality: FilterQuality.none,
                  useOldImageOnUrlChange: false,
                  fit: BoxFit.cover,
                  imageUrl: ImageServices.getImageUrlOf(widget.posterPath,
                      size: ImageServices.POSTER_SIZE_HIGHEST),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                )
              : Icon(Icons.local_movies),
        ));
  }
}
