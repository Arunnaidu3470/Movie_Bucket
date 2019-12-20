import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket/constants/constants.dart';
import 'package:movie_bucket/services/api_services.dart';

class CastDetails extends StatelessWidget {
  final List<dynamic> castList;
  CastDetails({@required this.castList});

  @override
  Widget build(BuildContext context) {
    // print(castList.map((index) {
    //   return index[CastConstants.PROFILE_PATH];
    // }));
    return _horizantolList();
  }

  Widget _horizantolList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Actors',
            // style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
              itemCount: castList.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 12.0, left: 20.0),
              itemBuilder: (_, index) {
                return CastTile(
                  imgPath: castList[index][CastConstants.PROFILE_PATH],
                  name: castList[index][CastConstants.NAME],
                  characterName: castList[index][CastConstants.CHARACTER_NAME],
                );
              }),
        ),
      ],
    );
  }
}

class CastTile extends StatefulWidget {
  final String imgPath;
  final String name;
  final String characterName;
  CastTile({this.imgPath, this.name, this.characterName});

  @override
  _CastTileState createState() => _CastTileState();
}

class _CastTileState extends State<CastTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          if (widget.imgPath != null)
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  APIServices.getImageUrlOfMovie(widget.imgPath)),
              radius: 40.0,
            )
          else
            CircleAvatar(
              child: Icon(
                Icons.account_circle,
                size: 40.0,
              ),
              radius: 40.0,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(widget.name),
          ),
        ],
      ),
    );
  }
}
