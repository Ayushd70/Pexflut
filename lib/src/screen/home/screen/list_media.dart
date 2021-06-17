import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/image.dart';
import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_state.dart';

class ListMedia extends StatefulWidget {
  final int mediaType;
  ListMedia(
    this.mediaType,
  );
  @override
  _ListMediaState createState() => _ListMediaState();
}

class _ListMediaState extends State<ListMedia> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late MediaListBloc _mediaListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _mediaListBloc = BlocProvider.of<MediaListBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _mediaListBloc.add(FetchData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (BuildContext context, state) {
        if (state is InitialList) {
          _mediaListBloc.add(FetchData());
          return Container();
        }
        if (state is Fetching) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShowList) {
          return GridView.extent(
            controller: _scrollController,
            maxCrossAxisExtent: 650,
            children: state.mediaType == photoCode
                ? _builPhotos(state.photos)
                : _buildVideos(state.videos),
          );
        }
        return Center(
          child: Text('Something wrong'),
        );
      },
    );
  }

  List<Widget> _builPhotos(List<Photo> photos) {
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
        ListMedia(photoCode),
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
