import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


/// CustomImage 组件
/// foliage
/// 基于 cached_network_image 封装
/// [imageUrl] 图片地址
/// [fit] 填充方式
class CustomImage extends StatefulWidget {
  const CustomImage({super.key, required this.imageUrl, this.fit});

  final String imageUrl;
  final BoxFit? fit;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: _buildImage,
      progressIndicatorBuilder: _buildProgress,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildProgress(context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
        ),
      );

  Widget _buildImage(context, imageProvider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
