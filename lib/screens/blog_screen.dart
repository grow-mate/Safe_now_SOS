import 'package:flutter/material.dart';
import '../services/blog_service.dart';

class BlogScreen extends StatelessWidget {
  final BlogService blogService;

  const BlogScreen({Key? key, required this.blogService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> blogs = blogService.getBlogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(blog['title']!),
              onTap: () => _showBlogDetail(context, blog),
            ),
          );
        },
      ),
    );
  }

  void _showBlogDetail(BuildContext context, Map<String, String> blog) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(blog['title']!),
          content: SingleChildScrollView(
            child: Text(blog['content']!),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
