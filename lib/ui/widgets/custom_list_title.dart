import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rik_and_morty/ui/widgets/characret_status.dart';

import '../../data/models/character.dart';

class CustomListTitle extends StatelessWidget {
  final Results result;
  const CustomListTitle({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: Colors.grey,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                   // width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      result.name,
                    ),
                  ),
                  CharacterStatus(
                    liveState: result.status == 'Alive'
                        ? LiveState.alive
                        : result.status == 'Dead'
                            ? LiveState.dead
                            : LiveState.unknown,
                  ),
                  SizedBox(
                 //   width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(
                      result.species,
                    ),
                  ),
                  SizedBox(
                 //   width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(
                      result.gender,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
