//This file contains homescreen components and layout

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bucket/app/ui/widgets/state_handler_widget.dart';

import '../../.././app/ui/widgets/custom_tab_bar.dart';
import '../../.././app/ui/widgets/linear_strip.dart';
import '../../../blocs/blocs.dart';
import '../../../utils/utils.dart' as utils;

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviePopularBloc>(context).add(MoviePopularFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => BlocProvider.of<MoviePopularBloc>(context)
            .add(MoviePopularFetchEvent()),
        label: Text('Refresh'),
        icon: Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: HomeHeaderMenu(
                      onSelect: print,
                    ),
                  ),
                  SliverToBoxAdapter(child: PopularMovies()),
                  SliverToBoxAdapter(child: DiscoverMovies()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header section
class HomeHeaderMenu extends StatefulWidget {
  final Function(int index) onSelect;

  HomeHeaderMenu({Key key, this.onSelect}) : super(key: key);

  @override
  _HomeHeaderMenuState createState() => _HomeHeaderMenuState();
}

class _HomeHeaderMenuState extends State<HomeHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
      ),
      width: MediaQuery.of(context).size.width,
      height: 300,
      padding: const EdgeInsets.only(left: 20, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hi, what\'s next?',
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                HeaderItem(
                  icon: Icon(
                    Icons.local_movies,
                    color: Colors.white,
                  ),
                  label: 'Movies',
                ),
                HeaderItem(
                  icon: Icon(
                    Icons.tv,
                    color: Colors.white,
                  ),
                  label: 'Tv Shows',
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CustomTabBar<utils.Genres>(
            onSelect: (index, value) {
              //TODO: on select show respective
            },
            children: utils.GENRE_LIST_INDEX
                .map((lable) => HeaderItem<utils.Genres>(
                    label: lable['name'], value: lable['enum']))
                .toList(),
          )
        ],
      ),
    );
  }
}

class PopularMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviePopularBloc, MovieState>(
      bloc: BlocProvider.of<MoviePopularBloc>(context),
      builder: (cxt, state) {
        return StateHandlerWidget(
          currentState: state,
          initialState: (cxt) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          },
          loadingState: (cxt) {
            return Container(
                margin: const EdgeInsets.all(8),
                child: Center(child: CircularProgressIndicator()));
          },
          loadedState: (cxt) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Popular',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      GestureDetector(
                        child: Text('show all'),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 220,
                  child: LinearStrip(
                    movieList: state.movieList,
                    onSelect: (index, id, heroTag) {
                      // TODO:nextscreen
                    },
                  ),
                ),
              ],
            );
          },
          errorState: (cxt) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error.message,
                  ),
                  action: SnackBarAction(
                      label: 'Retry',
                      onPressed: () {
                        BlocProvider.of<MoviePopularBloc>(context).add(
                          MoviePopularFetchEvent(),
                        );
                      }),
                ),
              );
            });
            return Container();
          },
          invalidState: (_) => Container(),
        );
      },
    );
  }
}

class DiscoverMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: IndexedStack(
        index: 1,
        alignment: Alignment.center,
        sizing: StackFit.loose,
        children: [],
      ),
    );
  }
}
