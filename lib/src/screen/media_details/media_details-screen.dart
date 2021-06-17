import 'package:pex_flut/src/screen/home/bloc/media_list_bloc.dart';
import 'package:pex_flut/src/screen/media_details/bloc/media_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/media_detail_bloc.dart';

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
        leading: IconButton(
            onPressed: () => Navigator.popAndPushNamed(context, 'home'),
            icon: Icon(Icons.arrow_back)),
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
                return Image.network(state.photo.src.large);
              } else {
                return Image.network(state.video.videoPictures[0].picture);
              }
            } else {
              return Text('Something wrong');
            }
          }),
    );
  }
}