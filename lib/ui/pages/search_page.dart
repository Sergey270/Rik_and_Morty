import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rik_and_morty/bloc/character_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      children: [
        state.when(
            loading: () {
              return const Center(
                child: Row(
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
            error: () => const Text('Nothing found')),
      ],
    );
  }
}
