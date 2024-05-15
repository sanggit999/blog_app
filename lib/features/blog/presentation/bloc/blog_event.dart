part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final File image;
  final String postedId;
  final String title;
  final String content;
  final List<String> topics;

  BlogUpload({
    required this.image,
    required this.postedId,
    required this.title,
    required this.content,
    required this.topics,
  });
}

final class BlogFetchAllBlogs extends BlogEvent {}
