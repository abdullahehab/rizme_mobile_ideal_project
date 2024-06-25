import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';

import '../../../../components/video_preview_widget.dart';
import '../../../../config/helpers/constants.dart';
import '../../../../config/helpers/content_locale.dart';
import '../../../../config/helpers/media_type_checker.dart';
import '../../../../generated/localization.dart';
import '../../../../models/post/post.dart';
import '../../../../models/post_media/post_media.dart';

typedef MediaSliderOpened = void Function(int index);

class PostBody extends StatefulWidget {
  final Post post;
  final MediaSliderOpened onMediaSliderOpened;
  const PostBody({
    super.key,
    required this.post,
    required this.onMediaSliderOpened,
  });

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  late final String content;
  bool isExpanded = false;
  bool hasURL = false;
  String url = "";

  @override
  void initState() {
    content = widget.post.content;
    _checkContent();
    super.initState();
  }

  void _checkContent() {
    final elements = linkify(widget.post.content, options: const LinkifyOptions(looseUrl: true));
    if (elements.any((element) => element is UrlElement)) {
      hasURL = true;
      url = (elements.lastWhere((element) => element is UrlElement) as UrlElement).url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildPostContent(),
          ),
        ),
        const SizedBox(height: 10),
        if (hasURL && widget.post.images.isEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: AnyLinkPreview(link: url),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: _buildAssetsPreviewLayout(),
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    final textTheme = Theme.of(context).textTheme;
    final contentLength = content.length;
    final canExpand = contentLength > kDefaultContentMaxVisibleLength;
    String contentText = content;

    if (!isExpanded && canExpand) {
      contentText = contentText.substring(0, kDefaultContentMaxVisibleLength);
    }

    return Align(
      alignment: decideAlignment(context, content),
      child: InkWell(
        onTap: () {
          if (!canExpand) return;
          setState(() => isExpanded = !isExpanded);
        },
        child: RichText(
          textAlign: decideTextAlignment(context, content),
          text: TextSpan(
            children: [
              LinkifySpan(
                text: contentText,
                style: textTheme.bodyLarge,
                linkStyle: textTheme.bodyLarge?.copyWith(
                  color: Colors.blueAccent,
                ),
                linkifiers: const [
                  ...defaultLinkifiers,
                  // HashtagLinkifier(),
                ],
                options: const LinkifyOptions(looseUrl: true, humanize: false),
                onOpen: (link) async {
                  // if (link is HashtagElement) {
                  //   return;
                  // }
                  await Constants.openLink((link as UrlElement).url);
                },
              ),
              if (canExpand) ...[
                TextSpan(
                  text: isExpanded ? "\t" : "...\t",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: isExpanded ? LocaleKeys.readLess.tr() : LocaleKeys.readMore.tr(),
                  style: textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetsPreviewLayout() {
    const boxFit = BoxFit.cover;
    final size = MediaQuery.of(context).size;
    final height = size.height * .25;
    final assets = widget.post.images;

    Widget layout = switch (assets.length) {
      1 => InkWell(
          onTap: () => widget.onMediaSliderOpened(assets.indexOf(assets.first)),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          child: _buildAssetPreviewWidget(
            assets.first,
            height: height,
            fit: boxFit,
          ),
        ),
      2 => Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => widget.onMediaSliderOpened(assets.indexOf(assets.first)),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                child: _buildAssetPreviewWidget(
                  assets.first,
                  height: height,
                  fit: boxFit,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: InkWell(
                onTap: () => widget.onMediaSliderOpened(assets.indexOf(assets.last)),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                child: _buildAssetPreviewWidget(
                  assets.last,
                  height: height,
                  fit: boxFit,
                ),
              ),
            ),
          ],
        ),
      (>= 3) => SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () => widget.onMediaSliderOpened(assets.indexOf(assets.first)),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  child: _buildAssetPreviewWidget(
                    assets.first,
                    height: height,
                    fit: boxFit,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => widget.onMediaSliderOpened(1),
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        child: _buildAssetPreviewWidget(
                          assets[1],
                          height: height,
                          fit: boxFit,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () => widget.onMediaSliderOpened(2),
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        child: _buildAssetPreviewWidget(
                          assets[2],
                          height: height,
                          fit: boxFit,
                          moreAssetsCount: assets.length - 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
    return layout;
  }

  Widget _buildAssetPreviewWidget(
    PostMedia asset, {
    double? height,
    BoxFit fit = BoxFit.cover,
    int? moreAssetsCount,
  }) {
    if (asset.mediaType == MediaType.video) {
      return VideoPreviewWidget(
        canDelete: false,
        videoUrl: asset.mediaUrl,
        height: height,
        width: double.infinity,
        fit: fit,
        moreVideosCount: moreAssetsCount,
      );
    }
    return PostNetworkImage(
      asset.mediaUrl,
      fit: fit,
      height: height,
      moreImagesCount: moreAssetsCount,
    );
  }
}

class PostNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? height;
  final int? moreImagesCount;
  const PostNetworkImage(
    this.url, {
    super.key,
    this.height,
    this.moreImagesCount,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: fit,
            height: height,
            width: double.infinity,
            errorWidget: (_, __, ___) => Icon(
              Icons.error,
              color: Colors.red.shade300,
            ),
          ),
        ),
        if (moreImagesCount != null && moreImagesCount! > 0) ...[
          Align(
            alignment: const AlignmentDirectional(0.85, .85),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                '+${moreImagesCount!}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
