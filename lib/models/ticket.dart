class Ticket {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String status; // OPEN, IN_PROGRESS, DONE
  final String createdAt;

  Ticket({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
