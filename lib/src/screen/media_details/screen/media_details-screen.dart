import 'package:pex_flut/src/screen/home/bloc/media_list_bloc.dart';
import 'photo_show_screen.dart';
import '../bloc/media_detail_bloc.dart';
import 'video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailScreen extends StatelessWidget {
  final String mediaType;
  final String mediaKey;

  MediaDetailScreen(this.mediaType, this.mediaKey);
  @override
  Widget build(BuildContext context) {
    print(mediaType);
    print(mediaKey);
    return BlocProvider(
      create: (BuildContext context) => MediaDetailBloc(),
      child: MediaDetail(mediaType, mediaKey),
    );
  }
}

class MediaDetail extends StatelessWidget {
  final String mediaType;
  final String mediaKey;
  MediaDetail(this.mediaType, this.mediaKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<MediaDetailBloc, MediaDetailState>(
          builder: (BuildContext context, state) {
            if (state is InitialMediaDetailState) {
              BlocProvider.of<MediaDetailBloc>(context).add(
                InitialMediaDetailEvent(mediaType: mediaType, mediaKey: mediaKey),
              );
            }
            if (state is LoadingMediaState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ShowMediaState) {
              if (state.mediaType == photoCode) {
                return PhotoShowScreen(
                  state: state,
                );
              } else {
                return VideoPlayerScreen(state: state);
              }
            } else {
              return Text('Something wrong');
            }
          }),
    );
  }
}