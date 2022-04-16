import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/model/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_detail_event.dart';
import '../bloc/media_detail_state.dart';
import 'package:rubber/rubber.dart';
import '../bloc/media_detail_bloc.dart';
import 'package:flutter/material.dart';

class PhotoShowScreen extends StatefulWidget {
  final ShowMediaState state;

  PhotoShowScreen({required this.state});

  @override
  _PhotoShowScreenState createState() => _PhotoShowScreenState();
}

class _PhotoShowScreenState extends State<PhotoShowScreen>
    with SingleTickerProviderStateMixin {
  late RubberAnimationController _controller;

  Photo get photo => widget.state.photo!;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        duration: Duration(milliseconds: 200),
        initialValue: 0.1);
    _controller.addStatusListener(_statusListener);
    _controller.animationState.addListener(_stateListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.animationState.removeListener(_stateListener);
    super.dispose();
  }

  void _stateListener() {}

  void _statusListener(AnimationStatus status) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RubberBottomSheet(
        lowerLayer: _getLowerLayer(),
        upperLayer: _getUpperLayer(),
        animationController: _controller,
      ),
    );
  }

  Widget _getLowerLayer() {
    return (this.photo.width > this.photo.height)
        ? buildHorizontalPhoto()
        : buildVerticalPhoto();
  }

  Widget _getUpperLayer() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _builPhotoList(widget.state.relatedPhoto!, context),
        ),
      ),
    );
  }

  List<Widget> _builPhotoList(List<Photo> photos, BuildContext context) {
    List<GestureDetector> imagesList = [];
    for (Photo photo in photos) {
      imagesList.add(
        GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(
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
              child: Image.network(photo.src.small, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return imagesList;
  }

  Widget buildHorizontalPhoto() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(this.photo.src.large),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.photo.photographer,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Size: ${this.photo.width} x ${this.photo.height}')
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<MediaDetailBloc>(context).add(
                            LikedEvent(
                                mediaTypeCode: photoCode,
                                mediaID: this.photo.id));
                      },
                      icon: Icon(
                        this.photo.liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVerticalPhoto() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Image.network(this.photo.src.large)),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.photo.photographer,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text('Size: ${this.photo.width} x ${this.photo.height}')
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        this.photo.liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        BlocProvider.of<MediaDetailBloc>(context).add(
                            LikedEvent(
                                mediaTypeCode: photoCode,
                                mediaID: this.photo.id));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}
