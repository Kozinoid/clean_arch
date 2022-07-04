import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PersonsCachedImage extends StatelessWidget {
  const PersonsCachedImage(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height,
        this.fourCorners = false})
      : super(key: key);

  final String imageUrl;
  final double width, height;
  final bool fourCorners;

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: fourCorners ? const BorderRadius.all(Radius.circular(20)) : const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return _imageWidget(const AssetImage('assets/images/no_image.jpg'));
      },
    );
  }
}
