import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogModel});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogModel = [];
    box.read(() {
      for (int i = 0; i < blogModel.length; i++) {
        blogModel.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogModel;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogModel}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogModel.length; i++) {
        box.put(i.toString(), blogModel[i].toJson());
      }
    });
  }
}
