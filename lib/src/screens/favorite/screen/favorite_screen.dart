import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/screens/home/screen/media_widget.dart';
import '../bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'media_widget.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (BuildContext context) =>
          FavoriteBloc()..add(FavoriteFetchEvent()),
          child: MediaFavoriteList(),
        ));
  }
}

class MediaFavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteInitialState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FavoriteFailureState) {
          return Center(
            child: Text('failed to fetch MediaLists'),
          );
        }
        if (state is FavoriteSuccessState) {
          if (state.mediaList.isEmpty) {
            return Center(
              child: Text('no MediaLists'),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 650 + 1),
            itemBuilder: (BuildContext context, int index) {
              return state.mediaList[index] is Photo
                  ? BuildMediaWidget(photo: state.mediaList[index])
                  : BuildMediaWidget(video: state.mediaList[index]);
            },
            itemCount: state.mediaList.length,
          );
        } else
          return Center(
            child: Text('Something wrong'),
          );
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}