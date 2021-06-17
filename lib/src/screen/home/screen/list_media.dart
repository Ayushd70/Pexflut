import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/image.dart';
import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_state.dart';

class ListMedia extends StatelessWidget {
  final int mediaType;
  ListMedia(
    this.mediaType,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
        builder: (BuildContext context, state) {
      if (state is InitialList) {
        BlocProvider.of<MediaListBloc>(context)
            .add(FetchData(mediaType: mediaType, page: 1, keyWord: ''));
        return Container();
      }
      if (state is Fetching) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ShowList) {
        return GridView.extent(
          maxCrossAxisExtent: 650,
          children: state.mediaType == 0
              ? _builPhotos(state.photos)
              : _buildVideos(state.videos),
        );
      }
      return Center(
        child: Text('Something wrong'),
      );
    });
  }

  List<Widget> _builPhotos(List<Photo> photos) {
    print(photos);
    List<GestureDetector> imagesList = [];
    for (Photo photo in photos) {
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
          ),
        ),
      );
    }
    return imagesList;
  }

  List<Widget> _buildVideos(List<Video> videos) {
    print(videos);
    List<GestureDetector> videosList = [];
    for (Video video in videos) {
      videosList.add(
        GestureDetector(
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(video.videoPictures[0].picture,
                  fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return videosList;
  }
}

class PageViewMedia extends StatelessWidget {
  final PageController _pageController;

  const PageViewMedia(this._pageController);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Container(
          color: Colors.red,
        ),
        ListMedia(videoCode),
        ListMedia(imageCode),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.purple,
        ),
      ],
    );
  }
}
