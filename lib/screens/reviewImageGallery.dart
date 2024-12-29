import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/reviewGalleryViewModel.dart';
import 'package:provider/provider.dart';

class ReviewImageGallery extends StatefulWidget {

 int id;
ReviewImageGallery({super.key,required this.id});

  @override
  State<ReviewImageGallery> createState() => _ReviewImageGalleryState();
}

class _ReviewImageGalleryState extends State<ReviewImageGallery> {
  int _currentIndex = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final reviewGalleryView =
          Provider.of<ReviewGalleryViewModel>(context, listen: false);

      reviewGalleryView.reviewImagesUiHandler(
        context,
        product_id: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewGalleryView = context.watch<ReviewGalleryViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: reviewGalleryView.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImageViewer(
                    imageUrls: reviewGalleryView.images,
                    initialIndex: _currentIndex,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                reviewGalleryView.images[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImageViewer extends StatefulWidget {
  final List<dynamic> imageUrls;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: kWhiteColor,
        title: Text('${_currentIndex + 1} / ${widget.imageUrls.length}'),
      ),
      body: PageView.builder(
        itemCount: widget.imageUrls.length,
        controller: PageController(initialPage: _currentIndex),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Image.network(
              widget.imageUrls[index],
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image));
              },
            ),
          );
        },
      ),
    );
  }
}
