class Player {
  Player({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.wins = 0,
    this.isActive = false,
  });

  final String id;
  final String name;
  final String imageUrl;
  int wins;
  bool isActive;

  Player copyWith({
    String? name,
    String? imageUrl,
    int? wins,
    bool? isActive,
  }) {
    return Player(
      id: id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      wins: wins ?? this.wins,
      isActive: isActive ?? this.isActive,
    );
  }
}
