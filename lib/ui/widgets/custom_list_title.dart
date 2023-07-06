import 'package:flutter/material.dart';

import '../../data/models/character.dart';


class CustomListTitle extends StatelessWidget {
  final Results result;
  const CustomListTitle({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(result.name, style: const TextStyle(color: Colors.white),),
    );
  }
}
