class Player {
  Player({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.wins = 0,
    this.isActive = false,
  });

  final int id;
  final String name;
  final String imageUrl;
  final int wins;
  bool isActive;
}
