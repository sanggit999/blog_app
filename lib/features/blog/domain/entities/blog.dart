class Blog {
  final String id;
  final DateTime updatedAt;
  final String postedId;
  final String imageUrl;
  final String title;
  final String content;
  final List<String> topics;
  final String? postedName;

  Blog(
      {required this.id,
      required this.updatedAt,
      required this.postedId,
      required this.imageUrl,
      required this.title,
      required this.content,
      required this.topics,
      this.postedName});
}
