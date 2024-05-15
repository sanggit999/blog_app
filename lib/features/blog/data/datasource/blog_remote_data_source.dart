import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  });

  Future<List<BlogModel>> getAllBlog();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final uploadBlog = await supabaseClient
          .from("blogs")
          .insert(blogModel.toJson())
          .select();

      return BlogModel.fromJson(uploadBlog.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from("blog_images")
          .upload(blogModel.id, image);

      return supabaseClient.storage
          .from("blog_images")
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogs =
          await supabaseClient.from("blogs").select("*,profiles(name)");
      return blogs
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(postedName: blog["profiles"]["name"]))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
