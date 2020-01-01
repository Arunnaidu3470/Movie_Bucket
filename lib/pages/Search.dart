import 'package:flutter/material.dart';
import '../pages/Movie_details.dart';
import '../pages/People_detail.dart';
import '../pages/TVShow_details.dart';
import '../services/Tv_apiServices.dart';
import '../services/api_services.dart';
import '../services/SearchApi.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textEditingController = TextEditingController();
  String _query;
  List<dynamic> _searchSuggestions;
  @override
  void initState() {
    getSuggestions();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SafeArea(child: _search()),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _searchResults(),
          ),
        ));
  }

  Widget _search() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      controller: _textEditingController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(1),
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          isDense: false,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.amber,
          ),
          suffixIcon: _eraseSearch(),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white)),
      onChanged: _onValueChanged,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
    );
  }

  getSuggestions() async {
    Map<String, dynamic> tvResult = await TVServices.getPopularShows();
    setState(() {
      _searchSuggestions = tvResult['results'];
    });
  }

  Widget _eraseSearch() {
    if (_query == null || _query.isEmpty) return null;
    return IconButton(
      icon: Icon(
        Icons.cancel,
        color: Colors.red[300],
      ),
      onPressed: () {
        _textEditingController.clear();
      },
    );
  }

  Widget _chipSuggestions() {
    if (_searchSuggestions == null) return LinearProgressIndicator();
    List<Widget> chips = _searchSuggestions.map((item) {
      return Container(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _textEditingController.text = item['name'];
            });
            _onValueChanged(item['name']);
          },
          child: Chip(
            shape: StadiumBorder(
                side: BorderSide(color: Colors.black, width: 0.1)),
            label: Text(item['name']),
          ),
        ),
      );
    }).toList();
    return Wrap(
      spacing: 5,
      children: chips,
    );
  }

  Widget _searchResults() {
    if (_query == null || _query.isEmpty)
      return Center(
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _searchSuggestions == null ? 0 : 1,
            child: _chipSuggestions()),
      );
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: SearchServices.searchMovie(_query),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return _resultBuild(snapshot.data);
        },
      ),
    );
  }

  Widget _resultBuild(List<dynamic> results) {
    return Container(
      child: ListView.builder(
        itemCount: results.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
            child: GestureDetector(
              onTap: () => _onTapResult(index, results[index]['media_type'],
                  results[index]['id'], results[index]['name'],
                  result: results[index]),
              child: Card(
                child: _tile(index: index, result: results),
              ),
            ),
          );
        },
      ),
    );
  }

  ListTile _tile({int index, List<dynamic> result}) {
    String mediaType = result[index]['media_type'];
    String movieTitle = result[index]['title'];
    String tvTitle = result[index]['name'];
    String tvImage = result[index]['poster_path'];
    String movieImage = result[index]['poster_path'];
    String personName = result[index]['name'];
    String personImage = result[index]['profile_path'];
    Color color = Theme.of(context).primaryColor;
    if (mediaType == 'tv') {
      //if result is tv
      return ListTile(
        title: Text(tvTitle == null ? ' ' : tvTitle),
        subtitle: Text(
          mediaType == null ? ' ' : mediaType,
        ),
        leading: tvImage != null
            ? _tileImage(tvImage)
            : Icon(
                Icons.tv,
                color: color,
              ),
      );
    } else if (mediaType == 'movie') {
      //if result is a movie
      return ListTile(
        title: Text(movieTitle == null ? ' ' : movieTitle),
        subtitle: Text(
          mediaType == null ? ' ' : mediaType,
        ),
        leading: movieImage != null
            ? _tileImage(movieImage)
            : Icon(
                Icons.local_movies,
                color: color,
              ),
      );
    } else if (mediaType == 'person') {
      //if result is a person
      return ListTile(
        title: Text(personName == null ? ' ' : personName),
        subtitle: Text(
          mediaType == null ? ' ' : mediaType,
        ),
        leading: personImage != null
            ? _tileImage(personImage)
            : Icon(
                Icons.person,
                color: color,
              ),
      );
    } else {
      return ListTile(
        title: Text('error'),
      );
    }
  }

  Widget _tileImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FadeInImage.assetNetwork(
        image: ImageServices.getImageUrlOf(image,
            size: ImageServices.POSTER_SIZE_LOW),
        placeholder: 'assets/loading.png',
        fit: BoxFit.cover,
      ),
    );
  }

  _onTapResult(int index, String mediaType, int id, String title,
      {Map<String, dynamic> result}) {
    String movieTitle = result['title'];
    String tvTitle = result['name'];
    String personName = result['name'];
    switch (mediaType) {
      case 'movie':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetailsPage(
            id: id,
            title: movieTitle,
          );
        }));
        break;
      case 'tv':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TVShowDetailsPage(
            showId: id,
            title: tvTitle,
          );
        }));
        break;
      case 'person':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PeopleDetailPage(
            castId: id,
            castName: personName,
          );
        }));
        break;
      default:
        print('unknown');
    }
  }

  _onValueChanged(String value) {
    setState(() {
      _query = value?.toString();
    });
  }
}
