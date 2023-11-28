import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/Api/api_client.dart';
import 'package:hrms/common/loading_overlay.dart';
import 'package:hrms/common/page_status.dart';
import 'package:hrms/now_playing/bloc/now_playing_bloc.dart';
import 'package:hrms/now_playing/bloc/now_playing_event.dart';
import 'package:hrms/now_playing/bloc/now_playing_repository.dart';
import 'package:hrms/now_playing/bloc/now_playing_state.dart';
import 'package:hrms/now_playing/model/Movie_list.dart';
import 'package:hrms/now_playing/widget/movie_list_items.dart';

import '../common/utility.dart';

class NowPlayingMoviePage extends StatefulWidget {
  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  late NowPlayingBloc _bloc;
  late LoadingOverlay _overlay;
  List<Results> moviesDetails = <Results>[];
  String filterKey = "";
  final TextEditingController _filterKeyTextEditingController =
      TextEditingController();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _bloc = NowPlayingBloc(NowPlayingRepository(ApiClient()));
    _overlay = LoadingOverlay();
    _bloc.add(FetchNowPlayingMovieListEvent(filterKey));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NowPlayingBloc>(
      create: (context) => _bloc,
      child: BlocListener<NowPlayingBloc, NowPlayingState>(
        listener: (context, state) {
          _handleState(state);
        },
        child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.yellow,
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextFormField(
                    controller: _filterKeyTextEditingController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      filterKey = _filterKeyTextEditingController.text;
                      _bloc.add(FetchNowPlayingMovieListEvent(filterKey));
                    },
                    decoration: InputDecoration(
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _filterKeyTextEditingController.clear();
                            },
                            icon: const Icon(Icons.cancel)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: " Search "),
                  ),
                ),
              ),
              body: Visibility(
                visible: isVisible,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    if (moviesDetails.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: moviesDetails.length,
                            itemBuilder: ((context, index) {
                              final movie = moviesDetails[index];
                              return Dismissible(
                                  key: Key(movie.id.toString()),
                                  onDismissed: (direction) {
                                    setState(() {
                                      moviesDetails.removeAt(index);
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${movie.originalTitle} dismissed"),
                                      ),
                                    );
                                  },
                                  child: MovieListItems(moviesDetails[index]));
                            })),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _handleState(NowPlayingState state) {
    if (state.pageStatus == PageStatus.loading) {
      _overlay.show(context);
    }
    if (state.pageStatus == PageStatus.success) {
      _overlay.hide();
      if (state is MovieListLoadedState) {
        moviesDetails = state.movieDetails;
        if (moviesDetails.isNotEmpty) {
          isVisible = true;
        }
      }
    }
    if (state.pageStatus == PageStatus.failure) {
      _overlay.hide();
      Utility().showErrorSnackBar(context, state.message!);
    }
    if (state.pageStatus == PageStatus.unAuthorized) {
      _overlay.hide();
    }
  }
}
