import 'package:meta/meta.dart';

class Video {
  final String url;

  Video({
    @required this.url,
  }) : assert(url != null);
}
