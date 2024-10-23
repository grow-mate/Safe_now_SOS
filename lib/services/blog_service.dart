class BlogService {
  // Temporary list of blogs
  final List<Map<String, String>> _blogs = [
    {
      'title': 'How to Stay Safe During Emergencies',
      'content': 'Emergencies can strike at any moment. Make sure you are prepared by keeping emergency contacts ready, learning basic first aid, and staying informed about potential dangers in your area.'
    },
    {
      'title': 'The Importance of Having an SOS App',
      'content': 'An SOS app is a critical tool in times of distress. With location sharing, quick communication, and automated emergency messaging, you can alert authorities or your loved ones instantly.'
    },
  ];

  // Get all blogs
  List<Map<String, String>> getBlogs() {
    return _blogs;
  }
}
