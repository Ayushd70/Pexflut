import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photolist_bloc.dart';
import '../bloc/search_bloc.dart';
import 'list_media.dart';
import 'search_bar.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider<PhotoSearchBloc>(
            create: (BuildContext context) => PhotoSearchBloc(),
          ),
          BlocProvider<PhotoListBloc>(
            create: (BuildContext context) => PhotoListBloc(),
          )
        ],
        child: Scaffold(
          appBar: buildSearchBar(_controller),
          body: ListMedia(),
        ));
  }

  buildSearchBar(TextEditingController controller) {}
}