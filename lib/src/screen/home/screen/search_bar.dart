import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';

AppBar buildSearchBar(TextEditingController textEditingControler) {
  return AppBar(
    title: BlocBuilder<PhotoSearchBloc, PhotoSearchState>(
      builder: (BuildContext context, state) {
        if (state is InitialSearch) {
          return Row(
            children: [
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
                      controller: textEditingControler,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        BlocProvider.of<PhotoSearchBloc>(context)
                            .add(Submit(keyWord: value));
                      },
                    ),
                    IconButton(
                      onPressed: () => textEditingControler.clear(),
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
  );
}
