import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    if (imageUrl == "3b3") {
      return const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/3b3.jpeg'),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const SizedBox(
          width: 100,
          height: 100,
          child: Center(child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 100,
        color: Colors.red,
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 50,
        backgroundImage: imageProvider,
      ),
    );
  }
}
