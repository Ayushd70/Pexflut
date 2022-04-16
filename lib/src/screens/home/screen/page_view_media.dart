import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/model/image.dart';
import '../bloc/media_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';
import 'media_widget.dart';

typedef void BottomNavigationIndex(int index);

class PageViewMedia extends StatelessWidget {
  final PageController pageController;
  final BottomNavigationIndex pageCallback;
  PageViewMedia({
    required this.pageController,
    required this.pageCallback,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (int page) {
        BlocProvider.of<MediaListBloc>(context)
            .add(MediaListTypeChangeEvent(mediaTypeCode: page));
        pageCallback(page);
      },
      children: [
        MediaPage(
          mediaTypeCode: photoCode,
          key: PageStorageKey('photo'),
        ),
        MediaPage(
          mediaTypeCode: videoCode,
          key: PageStorageKey('video'),
        ),
      ],
    );
  }
}

class MediaPage extends StatefulWidget {
  final int mediaTypeCode;
  MediaPage({required this.mediaTypeCode, Key? key}) : super(key: key);
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 300.0;
  late MediaListBloc _mediaListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _mediaListBloc = BlocProvider.of<MediaListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaListBloc, MediaListState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MediaListInitialState) {
          _mediaListBloc.add(MediaListFetchedEvent());
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MediaListFailureState) {
          return Center(
            child: Text(connectFail),
          );
        }
        if (state is MediaListSuccessState) {
          if (widget.mediaTypeCode == photoCode) {
            if (state.photos.isEmpty) {
              return Center(
                child: Text(noResult),
              );
            }
          } else {
            if (state.videos.isEmpty) {
              return Center(
                child: Text(noResult),
              );
            }
          }

          return widget.mediaTypeCode == photoCode
              ? BuildMediaListWidget(
                  mediaList: state.photos,
                  hasReachedMax: state.hasReachedMax,
                  scrollController: _scrollController,
                )
              : BuildMediaListWidget(
                  mediaList: state.videos,
                  hasReachedMax: state.hasReachedMax,
                  scrollController: _scrollController,
                );
        } else
          return Center(
            child: Text(otherError),
          );
      },
    );
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
      _mediaListBloc.add(MediaListFetchedEvent());
    }
  }
}

class BuildMediaListWidget extends StatelessWidget {
  final List mediaList;
  final bool hasReachedMax;
  final ScrollController scrollController;
  BuildMediaListWidget({
    required this.mediaList,
    required this.hasReachedMax,
    required this.scrollController,
  });
  @override
  Widget build(BuildContext context) {
    if (mediaList[0] is Photo) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 650 + 1),
        itemBuilder: (BuildContext context, int index) {
          return index >= mediaList.length
              ? BottomLoader()
              : BuildMediaWidget(
                  photo: mediaList[index],
                  index: index,
                );
        },
        itemCount: hasReachedMax ? mediaList.length : mediaList.length + 1,
        controller: scrollController,
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 650 + 1),
        itemBuilder: (BuildContext context, int index) {
          return index >= mediaList.length
              ? BottomLoader()
              : BuildMediaWidget(
                  video: mediaList[index],
                  index: index,
                );
        },
        itemCount: hasReachedMax ? mediaList.length : mediaList.length + 1,
        controller: scrollController,
      );
    }
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
