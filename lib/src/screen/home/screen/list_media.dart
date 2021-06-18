import 'photo_widget.dart';
import 'video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/image.dart';
import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_state.dart';

class ListMedia extends StatefulWidget {
  final int mediaType;
  ListMedia({required this.mediaType, Key? key}) : super(key: key);

  @override
  _ListMediaState createState() => _ListMediaState();
}

class _ListMediaState extends State<ListMedia> {
  final _scrollController = ScrollController();
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
    if (maxScroll - currentScroll < 200) {
      _mediaListBloc.add(FetchDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (BuildContext context, state) {
        if (state is InitialListState) {
          _mediaListBloc.add(FetchDataEvent());
          return Center(child: CircularProgressIndicator());
        }
        if (state is FetchingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FetchingFailState) {
          return Center(
            child: Text('Failed to get data'),
          );
        }
        if (state is NoMatchingResultState) {
          return Center(
            child: Text('No matching result'),
          );
        }

        if (state is ShowListState) {
          return GridView.extent(
            controller: _scrollController,
            maxCrossAxisExtent: 650,
            children: widget.mediaType == photoCode
                ? _builPhotoList(state.photos)
                : _buildVideoList(state.videos),
          );
        }
        return Container();
      },
    );
  }

  List<Widget> _builPhotoList(List<Photo> photos) {
    List<Widget> imagesList = [];
    for (Photo photo in photos) {
      imagesList.add(
        PhotoWidget(
          photo: photo,
        ),
      );
    }
    return imagesList;
  }

  List<Widget> _buildVideoList(List<Video> videos) {
    List<Widget> videosList = [];
    for (Video video in videos) {
      videosList.add(
        VideoWidget(
          video: video,
        ),
      );
    }
    return videosList;
  }
}

class PageViewMedia extends StatefulWidget {
  final PageController _pageController;

  const PageViewMedia(this._pageController);
  @override
  _PageViewMediaState createState() => _PageViewMediaState();
}

class _PageViewMediaState extends State<PageViewMedia> {
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: PageView(
        controller: widget._pageController,
        onPageChanged: (int page) {
          BlocProvider.of<MediaListBloc>(context)
              .add(MediaTypeChangedEvent(mediaType: page));
        },
        children: [
          ListMedia(mediaType: photoCode, key: PageStorageKey('photo')),
          ListMedia(mediaType: videoCode, key: PageStorageKey('video')),
        ],
      ),
    );
  }
}