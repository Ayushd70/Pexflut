import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/screen/home/screen/home_screen.dart';
import 'src/screen/home/bloc/photolist_bloc.dart';
import 'src/screen/home/bloc/search_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PexFlut',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PhotoSearchBloc>(
            create: (BuildContext context) => PhotoSearchBloc(),
          ),
          BlocProvider<PhotoListBloc>(create: (BuildContext context) => PhotoListBloc(),)
        ],
        child: HomeScreen(),
      ),
    );
  }
}
