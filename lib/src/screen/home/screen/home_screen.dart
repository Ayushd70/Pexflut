import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_list_bloc.dart';
import '../bloc/search_bloc.dart';
import 'search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingControler;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _textEditingControler = TextEditingController();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotoSearchBloc>(
          create: (BuildContext context) => PhotoSearchBloc(),
        ),
        BlocProvider<MediaListBloc>(
          create: (BuildContext context) => MediaListBloc(),
        )
      ],
      child: Scaffold(
        appBar: buildSearchBar(_textEditingControler),
        body: PageViewMedia(_pageController),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControler.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
