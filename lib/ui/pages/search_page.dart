import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rik_and_morty/bloc/character_bloc.dart';
import 'package:rik_and_morty/ui/widgets/custom_list_title.dart';

import '../../data/models/character.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSearchStr = '';

  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;

  final _storage = HydratedBloc?.storage;

  @override
  void initState() {
    if(_storage.runtimeType.toString().isEmpty) {
      if (_currentResults.isEmpty) {
        context
            .read<CharacterBloc>()
            .add(const CharacterEvent.fetch(name: '', page: 1));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: 'Search name',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                _currentPage = 1;
                _currentResults = [];
                _currentSearchStr = value;
                context
                    .read<CharacterBloc>()
                    .add(CharacterEvent.fetch(name: value, page: _currentPage));
              },
            ),
          ),
          Expanded(
            child: state.when(
                loading: () {
                  if (!_isPagination) {
                    return const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('loading...'),
                        ],
                      ),
                    );
                  } else {
                    return _customListView(_currentResults);
                  }
                },
                loaded: (characterLoaded) {
                  _currentCharacter = characterLoaded;
                  if (_isPagination) {

                    _currentResults = List.from(_currentResults)..addAll(_currentCharacter.results);
                    refreshController.loadComplete();
                    _isPagination = false;
                  } else {
                    _currentResults = _currentCharacter.results;
                  }

                  return _currentResults.isNotEmpty
                      ? _customListView(_currentResults)
                      : const SizedBox();
                },
                error: () => const Text('Nothing found1')),
          ),
        ],
      ),
    );
  }

  Widget _customListView(List<Results> currentResults) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: () {
        _isPagination = true;
        _currentPage++;
        if (_currentPage <= _currentCharacter.info.pages) {
          context.read<CharacterBloc>().add(CharacterEvent.fetch(
              name: _currentSearchStr, page: _currentPage));
        } else {
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
        itemCount: _currentResults.length,
        separatorBuilder: (_, index) => const SizedBox(
          height: 5,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final result = currentResults[index];
          return Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 3, bottom: 3,),
            child: CustomListTitle(result: result),
          );
        },
      ),
    );
  }
}
