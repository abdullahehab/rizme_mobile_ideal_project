enum MediaType { image, video, unknown }

MediaType checkMediaType(String filename) {
  String extension = filename.split('.').last.toLowerCase();

  Map<String, MediaType> mediaTypeMap = {
    'jpeg': MediaType.image,
    'png': MediaType.image,
    'jpg': MediaType.image,
    'svg': MediaType.image,
    'mp4': MediaType.video,
    'avi': MediaType.video,
    'wmv': MediaType.video,
  };

  if (mediaTypeMap.containsKey(extension)) {
    return mediaTypeMap[extension]!;
  } else {
    return MediaType.unknown;
  }
}
