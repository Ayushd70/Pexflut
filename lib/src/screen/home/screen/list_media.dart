import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/media_repository.dart';
import '../../../models/image.dart';
import '../bloc/photolist_bloc.dart';
import '../bloc/photolist_event.dart';
import '../bloc/photolist_state.dart';

class ListMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoListBloc, PhotoListState>(
      builder: (BuildContext context, state) {
        if (state is InitialList) {
          BlocProvider.of<PhotoListBloc>(context)
              .add(FetchData(mediaType: MediaType.image, page: 1, keyWord: ''));
          return Center();
        }
        if (state is Fetching) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShowList) {
          return GridView.extent(
            maxCrossAxisExtent: 650,
            children: _buildImages(state.photos),
          );
        } else {
          return Center(
            child: Text('Something wrong'),
          );
        }
      },
    );
  }

  List<Widget> _buildImages(List<Photo> images) {
    List<GestureDetector> imagesList = [];
    for (Photo photo in images) {
      imagesList.add(
        GestureDetector(
            child: Container(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Image.network(photo.src.large, fit: BoxFit.cover),
              ),
            )),
      );
    }
    return imagesList;
  }
}