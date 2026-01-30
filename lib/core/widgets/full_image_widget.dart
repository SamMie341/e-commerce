import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImagePage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  DismissDirection dismissDirection = DismissDirection.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Dismissible(
          key: Key(widget.imageUrl),
          direction: dismissDirection,
          resizeDuration: null,
          movementDuration: const Duration(milliseconds: 0),
          onDismissed: (direction) => Navigator.pop(context),
          child: PhotoView(
            filterQuality: FilterQuality.low,
            tightMode: true,
            imageProvider: CachedNetworkImageProvider(widget.imageUrl),
            heroAttributes: PhotoViewHeroAttributes(
              tag: widget.heroTag,
              transitionOnUserGestures: true,
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4,
            scaleStateChangedCallback: (PhotoViewScaleState state) {
              setState(() {
                if (state == PhotoViewScaleState.initial) {
                  dismissDirection = DismissDirection.vertical;
                } else {
                  dismissDirection = DismissDirection.none;
                }
              });
            },
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}
