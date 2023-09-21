import 'package:sipkys/models/player.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

List<Player> dummyPlayers = [
  Player(
    id: uuid.v4(),
    name: 'Aleš',
    imageUrl: 'assets/images/snake.png',
    isActive: true,
  ),
  Player(
    id: uuid.v4(),
    name: 'Majkoslávek',
    imageUrl: 'assets/images/penguin.png',
    isActive: true,
  ),
  Player(
    id: uuid.v4(),
    name: 'Mára',
    imageUrl: 'assets/images/rabbit.png',
    isActive: true,
  ),
  Player(
    id: uuid.v4(),
    name: 'DlouhýNázevHráčeProTest',
    imageUrl: 'assets/images/monkey.png',
    wins: 15,
  ),
  Player(
    id: uuid.v4(),
    name: 'Alfík',
    imageUrl: 'assets/images/parrot.png',
    wins: 123,
  ),
];
