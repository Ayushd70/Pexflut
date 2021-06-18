import 'page_view_media.dart';
import '../bloc/search_bloc.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingControler;
  @override
  void initState() {
    super.initState();
    _textEditingControler = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MediaSearchBloc>(
          create: (BuildContext context) => MediaSearchBloc(),
        ),
        BlocProvider<MediaListBloc>(
          create: (BuildContext context) => MediaListBloc(),
        ),
      ],
      child: Scaffold(
        appBar: buildSearchBar(_textEditingControler),
        body: PageViewMedia(),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControler.dispose();
    super.dispose();
  }
}