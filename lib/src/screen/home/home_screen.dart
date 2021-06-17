import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:pex_flut/src/screen/home/bloc/photolist_state.dart';
import 'bloc/photolist_bloc.dart';
import 'bloc/photolist_event.dart';
import 'bloc/photolist_state.dart';
import 'bloc/search_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PhotoSearchBloc, PhotoSearchState>(
          builder: (BuildContext context, state) {

            if (state is InitialSearch) {
              return Row(
                children: [
                  OutlinedButton(
                    onPressed: () {  },
                    child: Text(
                      'Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Text('${state.keyWord}'),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => BlocProvider.of<PhotoSearchBloc>(context)
                        .add(SearchButton()),
                  ),
                ],
              );
            }
            if (state is Typing) {
              return Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () =>
                        BlocProvider.of<PhotoSearchBloc>(context).add(BackArrow()),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: [
                        TextField(
                          controller: _controller,
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            BlocProvider.of<PhotoSearchBloc>(context)
                                .add(Submit(keyWord: value));
                          },
                        ),
                        IconButton(
                          onPressed: () => _controller.clear(),
                          icon: Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text('Something wrong');
            }
          },
        ),
      ),
      body: ListMedia(),
    );
  }
}

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