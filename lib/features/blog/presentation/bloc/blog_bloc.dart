import 'dart:io';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAlllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAlllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog.call(UploadBlogParams(
      image: event.image,
      postedId: event.postedId,
      title: event.title,
      content: event.content,
      topics: event.topics,
    ));

    res.fold(
      (failure) => emit(
        BlogFailure(failure.message),
      ),
      (blog) => emit(
        BlogUploadSuccess("Blog đã tạo thành công."),
      ),
    );
  }

  void _onBlogFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs.call(NoParams());

    res.fold(
      (failure) => emit(
        BlogFailure(failure.message),
      ),
      (blog) => emit(
        BlogDisplaySuccess(blog),
      ),
    );
  }
}
