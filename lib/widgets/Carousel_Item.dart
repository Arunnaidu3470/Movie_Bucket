import 'package:flutter/material.dart';

import '../pages/Movie_details.dart';
import '../pages/TVShow_details.dart';
import '../services/Image_services.dart';

enum CarouselItemType {
  ///[CarouselItemType.movie] calls Movie Detail Page
  ///[CarouselItemType.tvShow] calls TVshow detail page
  movie,
  tvShow,
}

class CarouselItem extends StatelessWidget {
  ///CarouselItem is best used to create a item for CarouselWidget
  ///itemType takes [CarouselItemType] it is used to
  ///navigate between [MovieDetailspage] and [TVShowDetailsPage]
  ///[context] is requeried for navigation between pages
  ///This widget shows movies's title,backdropimage, poster image and popularity
  const CarouselItem({
    Key key,
    @required this.context,
    @required this.id,
    @required this.title,
    @required this.backgroundImage,
    @required this.forgroundImage,
    @required this.popularity,
    @required this.itemType,
  }) : super(key: key);

  final BuildContext context;
  final int id;
  final String title;
  final String backgroundImage;
  final String forgroundImage;
  final double popularity;
  final CarouselItemType itemType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (itemType == CarouselItemType.tvShow) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return TVShowDetailsPage(
              showId: this.id,
              title: this.title,
            );
          }));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MovieDetailsPage(
              id: this.id,
              title: this.title,
            );
          }));
        }
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
                    ImageServices.getImageUrlOf(this.backgroundImage,
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
                            this.forgroundImage,
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
                              this.title,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              textWidthBasis: TextWidthBasis.parent,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            _popularity(),
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

  Row _popularity() {
    double popularity = this.popularity;
    int temp = (popularity * 100.0).round();
    popularity = temp / 100;

    return Row(
      children: <Widget>[
        Icon(
          Icons.poll,
          color: Colors.yellow[100],
        ),
        Text(
          '$popularity',
          maxLines: 2,
          overflow: TextOverflow.fade,
          textWidthBasis: TextWidthBasis.parent,
          style: TextStyle(
              fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
