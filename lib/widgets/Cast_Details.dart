import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../pages/People_detail.dart';
import '../services/api_services.dart';

class CastDetails extends StatelessWidget {
  final List<dynamic> castList;
  final String widgetTitle;
  final IconData icon;
  CastDetails(
      {@required this.castList,
      this.widgetTitle = 'Actors',
      this.icon = Icons.recent_actors});

  @override
  Widget build(BuildContext context) {
    return _horizantolList(context);
  }

  Widget _horizantolList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                ' $widgetTitle',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
            ],
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
                  castId: castList[index][CastConstants.ACTOR_ID],
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
  final int castId;
  CastTile({this.imgPath, this.name, this.characterName, this.castId});

  @override
  _CastTileState createState() => _CastTileState();
}

class _CastTileState extends State<CastTile> {
  _goToPeopleDetailsPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return PeopleDetailPage(
        castId: widget.castId,
        castName: widget.name,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToPeopleDetailsPage(),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            if (widget.imgPath != null)
              CircleAvatar(
                backgroundImage: NetworkImage(ImageServices.getImageUrlOf(
                    widget.imgPath,
                    size: ImageServices.PROFILE_SIZE_MEDIUM)),
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
      ),
    );
  }
}
