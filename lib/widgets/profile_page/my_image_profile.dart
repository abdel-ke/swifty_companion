import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImageProfile extends StatelessWidget {
  const MyImageProfile({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.radius = 50,
    this.size = 100,
    this.circle = true,
  });

  final String imageUrl;
  final double width;
  final double height;
  final double radius;
  final double size;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => SizedBox(
            width: width,
            height: height,
            child: const Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => Icon(
              Icons.error,
              size: size,
              color: Colors.red,
            ),
        imageBuilder: circle == true
            ? (context, imageProvider) => CircleAvatar(
                  radius: radius,
                  backgroundImage: imageProvider,
                )
            : (context, imageProvider) => Image(
                image: imageProvider,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                width: width,
                height: height)
                );
  }
}
