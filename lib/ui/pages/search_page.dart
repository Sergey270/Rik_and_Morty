
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rik_and_morty/bloc/character_bloc.dart';

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



  @override
   void initState() {
    context
        .read<CharacterBloc>()
        .add(const CharacterEvent.fetch(name: 'name', page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: const TextStyle(color: Colors.white,),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon( Icons.search, color: Colors.white ),
              hintText : 'Search name',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: (value){
              context.read<CharacterBloc>().add(CharacterEvent.fetch(name: value, page: 1));
            },

    ),
        ),
        state.when(
            loading: () {
              return  const Center(
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
            },
            loaded: (characterLoaded) => Text('${characterLoaded.info}'),
            error: () => const Text('Nothing found1')),
      ],
    );
  }
}
