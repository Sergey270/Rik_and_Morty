import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LiveState { alive, dead, unknown }

class CharacterStatus extends StatelessWidget {
  final LiveState liveState;
  const CharacterStatus({super.key, required this.liveState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 16,
          color: liveState == LiveState.alive
              ? Colors.green
              : liveState == LiveState.dead
                  ? Colors.red
                  : Colors.white,
        ),
        const SizedBox(width: 1,),
        Text(liveState == LiveState.alive
            ? 'Alive'
            : liveState == LiveState.dead
            ? 'Dead'
            : 'Unknown',

        )
      ],
    );
  }
}
