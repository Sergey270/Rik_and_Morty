import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/character.dart';


class CustomListTitle extends StatelessWidget {
  final Results result;
  const CustomListTitle({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: Colors.grey,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.cyan,),
              errorWidget: (context, url, error)=> const Icon(Icons.error),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: Text(result.name, ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: Text(result.species, ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: Text(result.gender, ),
                ),
              ],
            )
          ],
        ),
        
      ),
    );
  }
}
