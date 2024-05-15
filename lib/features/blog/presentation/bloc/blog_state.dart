part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogUploadSuccess extends BlogState {
  final String success;

  BlogUploadSuccess(this.success);
}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure(this.message);
}

final class BlogLoading extends BlogState {}
