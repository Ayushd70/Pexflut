import '../bloc/media_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';

class VideoWidget extends StatelessWidget {
  final Video video;
  VideoWidget({required this.video});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, 'mediaDetail/$videoCode/${video.id}');
            },
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: 3.5, right: 3.5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      video.user.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(
                        video.liked
                            ? Icons.favorite_border
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        BlocProvider.of<MediaListBloc>(context)
                            .add(LikedMediaEvent(media: video));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.play_circle_filled,
              size: 150,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(
                  context, 'mediaDetail/$videoCode/${video.id}');
            },
          )
        ],
      ),
    );
  }
}