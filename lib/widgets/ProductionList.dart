import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../pages/People_detail.dart';
import '../services/api_services.dart';

class ProductionList extends StatelessWidget {
  final List<dynamic> list;
  final String listTitle;
  final IconData listIcon;
  ProductionList(
      {@required this.list,
      this.listTitle = 'Production',
      this.listIcon = Icons.videocam});

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
                listIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                ' $listTitle',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 12.0, left: 20.0),
              itemBuilder: (_, index) {
                return _Tile(
                  imgPath: list[index][ProductionConstant.LOGO_PATH],
                  name: list[index][ProductionConstant.NAME],
                  country: list[index][ProductionConstant.ORIGIN_COUNTRY],
                  id: list[index][ProductionConstant.ID],
                );
              }),
        ),
      ],
    );
  }
}

class _Tile extends StatefulWidget {
  final String imgPath;
  final String name;
  final String country;
  final int id;
  _Tile({this.imgPath, this.name, this.country, this.id});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<_Tile> {
  _goToPeopleDetailsPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return PeopleDetailPage(
        castId: widget.id,
        castName: widget.name,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => _goToPeopleDetailsPage(),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            if (widget.imgPath != null)
              CircleAvatar(
                backgroundImage: NetworkImage(ImageServices.getImageUrlOf(
                    widget.imgPath,
                    size: ImageServices.LOGO_SIZE_MEDIUM)),
                radius: 40.0,
              )
            else
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: Icon(
                  Icons.videocam,
                  size: 30.0,
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
