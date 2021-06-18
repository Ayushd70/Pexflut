import 'package:pex_flut/resource/resources.dart';
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

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int bottomNavigationIndex = 0;

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
        body: PageViewMedia(
          pageController: pageController,
          pageCallback: (index) => bottomSelected(index),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavigationIndex,
          items: buildBottomNavBarItems(),
          onTap: (index) => {
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease),
            bottomSelected(index)
          },
        ),
      ),
    );
  }

  void bottomSelected(int index) {
    setState(() {
      bottomNavigationIndex = index;
    });
  }

  @override
  void dispose() {
    _textEditingControler.dispose();
    super.dispose();
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.photo_album), label: photoString),
      BottomNavigationBarItem(
        icon: Icon(Icons.video_library),
        label: videoString,
      ),
    ];
  }
}