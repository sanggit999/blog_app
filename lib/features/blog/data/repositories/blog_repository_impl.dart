import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasource/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasource/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(this.blogRemoteDataSource, this.blogLocalDataSource,
      this.connectionChecker);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String postedId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet!"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        updatedAt: DateTime.now(),
        postedId: postedId,
        imageUrl: "",
        title: title,
        content: content,
        topics: topics,
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blogModel: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final getAll = await blogRemoteDataSource.getAllBlog();
      blogLocalDataSource.uploadLocalBlogs(blogModel: getAll);
      return right(getAll);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
