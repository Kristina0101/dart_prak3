import 'dart:io';

import 'board.dart';


class Player {
  String name;
  late Board board;
  int hits = 0;
  int misses = 0;
  int lostShips = 0;

  Player(this.name) {
    board = Board();
  }

  void makeMove(Board opponentBoard) {
    print("Введите координаты выстрела (например, 3 4):");
    String? input = stdin.readLineSync();
    if (input == null) {
      print("Неверный ввод!");
      return;
    }
    List<String> coords = input.split(' ');
    if (coords.length != 2) {
      print("Неверный ввод!");
      return;
    }

    int row = int.parse(coords[0]);
    int col = int.parse(coords[1]);

    bool hit = opponentBoard.shoot(row, col);
    if (hit) {
      hits += 1;
      print("Отличный выстрел, $name!");
    } else {
      misses += 1;
      print("Промах, $name. Попробуйте ещё раз.");
    }
  }
}
