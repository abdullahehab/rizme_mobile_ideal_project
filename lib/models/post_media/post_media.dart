import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../config/helpers/media_type_checker.dart';

part 'post_media.g.dart';

@JsonSerializable()
class PostMedia extends Equatable {
  final MediaType mediaType;
  final String mediaUrl;

  const PostMedia({
    required this.mediaType,
    required this.mediaUrl,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) => _$PostMediaFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaToJson(this);

  PostMedia copyWith({
    MediaType? mediaType,
    String? mediaUrl,
  }) {
    return PostMedia(
      mediaType: mediaType ?? this.mediaType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  @override
  List<Object?> get props => [mediaType, mediaUrl];
}
