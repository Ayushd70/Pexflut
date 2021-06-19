import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import '../bloc/favorite_event.dart';
import '../bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildMediaWidget extends StatefulWidget {
  final Photo? photo;
  final Video? video;

  const BuildMediaWidget({
    Key? key,
    this.photo,
    this.video,
  }) : super(key: key);

  @override
  _BuildMediaWidgetState createState() => _BuildMediaWidgetState();
}

class _BuildMediaWidgetState extends State<BuildMediaWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return (widget.photo == null)
        ? _buildVideoWidget(context, widget.video!)
        : _buildImageWidget(context, widget.photo!);
  }

  Widget _buildImageWidget(BuildContext context, Photo photo) {
    bool isLiked = true;
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
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(
                  context, 'mediaDetail/$photoCode/${photo.id}');
            },
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
                      photo.photographer,
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<FavoriteBloc>(context).add(DislikeEvent(
                            mediaTypeCode: photoCode, mediaID: photo.id));
                      },
                      icon: Icon(
                        // ignore: dead_code
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoWidget(BuildContext context, Video video) {
    bool isLiked = true;
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
                child: Image.network(
                    video.videoPictures[0].picture ??
                        'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 150,
                icon: Icon(
                  Icons.play_circle_filled,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(
                      context, 'mediaDetail/$videoCode/${video.id}');
                },
              ),
              SizedBox(height: 70),
            ],
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
                      onPressed: () {
                        BlocProvider.of<FavoriteBloc>(context).add(DislikeEvent(
                            mediaTypeCode: videoCode, mediaID: video.id));
                      },
                      icon: Icon(
                        // ignore: dead_code
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
