import 'dart:io';

import 'player.dart';

class Game {
  late Player player1;
  late Player player2;
  List <int> score = [0, 0];

  void start() {
    print("Добро пожаловать в Морской бой!");
    print("Игрок 1, введите своё имя:");
    String name1 = stdin.readLineSync()!;
    player1 = Player(name1);

    print("Игрок 2, введите своё имя:");
    String name2 = stdin.readLineSync()!;
    player2 = Player(name2);

    print("Игрок 1 расставляет корабли.");
    player1.board.placeShips();
    print("Игрок 2 расставляет корабли.");
    player2.board.placeShips();

    play();
  }

  void play() {
    Player current = player1;
    Player opponent = player2;

    while (true) {
      print("\nХодит ${current.name}");
      current.makeMove(opponent.board);

      if (opponent.board.isAllShipsSunk()) {
        current.board.display(showShips: true);
        opponent.board.display(showShips: true);
        
        print("Поздравляем, ${current.name}! Вы победили!");

        opponent.lostShips = 3 - opponent.board.remainingShips();

        print("\nСтатистика игры:");
        print("Игрок 1: ${player1.name}");
        print(" - Разрушил все корабли противника.");
        print(" - Потерял ${player1.lostShips} кораблей.");
        print(" - Попаданий: ${player1.hits}, промахов: ${player1.misses}.");
        print(" - Осталось кораблей: ${player1.board.remainingShips()}/3.");
        
        print("\nИгрок 2: ${player2.name}");
        print(" - Разрушил все корабли противника.");
        print(" - Потерял ${player2.lostShips} кораблей.");
        print(" - Попаданий: ${player2.hits}, промахов: ${player2.misses}.");
        print(" - Осталось кораблей: ${player2.board.remainingShips()}/3.");

        if (current == player1) {
          score[0] += 1;
        } else if (current == player2) {
          score[1] += 1;
        }
        print("\nТекущий счёт: \nИгрок 1: ${score[0]} \nИгрок 2: ${score[1]}");
        saveStatistics('GameResults');

        break;
      }

      Player temp = current;
      current = opponent;
      opponent = temp;
    }
  }

  void saveStatistics(String directoryName) {
    final directory = Directory(directoryName);
    if (!directory.existsSync()) {
      directory.createSync();
    }

    final file = File('${directory.path}/game_statistics.txt');
    final buffer = StringBuffer()
      ..writeln("Статистика игры:")
      ..writeln("Игрок 1:")
      ..writeln(" - Разрушил все корабли противника.")
      ..writeln(" - Потерял ${player1.lostShips} кораблей.")
      ..writeln(" - Попаданий: ${player1.hits}, промахов: ${player1.misses}.")
      ..writeln(" - Осталось кораблей: ${player1.board.remainingShips()}/3.")
      ..writeln()
      ..writeln("Игрок 2:")
      ..writeln(" - Разрушил все корабли противника.")
      ..writeln(" - Потерял ${player2.lostShips} кораблей.")
      ..writeln(" - Попаданий: ${player2.hits}, промахов: ${player2.misses}.")
      ..writeln(" - Осталось кораблей: ${player2.board.remainingShips()}/3.")
      ..writeln()
      ..writeln("Текущий счёт: ")
      ..writeln("Игрок 1: ${score[0]} \nИгрок 2: ${score[1]}");

    file.writeAsStringSync(buffer.toString());
    print("Статистика игры сохранена в файл");
  }

}
