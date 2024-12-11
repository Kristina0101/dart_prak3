import 'dart:io';

class Board {
  static const int size = 5;
  List<List<String>> grid;
  List<List<bool>> shipGrid;

  Board()
      : grid = List.generate(size, (_) => List.generate(size, (_) => '.')),
        shipGrid = List.generate(size, (_) => List.generate(size, (_) => false));

  void placeShips() {
    for (int i = 0; i < 3; i++) {
      while (true) {
        print("Введите координаты корабля $i (например: 1 2 (вводить числа от 0 до 4)):");
        String? input = stdin.readLineSync();
        if (input == null) continue;

        List<String> coords = input.split(' ');
        if (coords.length != 2) continue;

        int row = int.parse(coords[0]);
        int col = int.parse(coords[1]);

        if (row >= 0 && row < size && col >= 0 && col < size && !shipGrid[row][col]) {
          shipGrid[row][col] = true;
          print("Корабль $i размещён.");
          break;
        } else {
          print("Неверные координаты или место занято. Попробуйте снова.");
        }
      }
    }
    print("\nВаше поле готово:");
    display(showShips: true);
  }

  bool shoot(int row, int col) {
    if (row < 0 || row >= size || col < 0 || col >= size) {
      print("Выстрел вне поля!");
      return false;
    }

    if (grid[row][col] != '.') {
      print("Вы уже стреляли сюда!");
      return false;
    }

    if (shipGrid[row][col]) {
      grid[row][col] = 'X';
      shipGrid[row][col] = false;
      print("Попадание!");
      display();
      return true;
    } else {
      grid[row][col] = 'O';
      print("Мимо!");
      display();
      return false;
    }
  }

  bool isAllShipsSunk() {
    for (var row in shipGrid) {
      if (row.contains(true)) {
        return false;
      }
    }
    return true;
  }

  void display({bool showShips = false}) {
    print("\nПоле:");
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (showShips && shipGrid[row][col]) {
          stdout.write("*");
        } else {
          stdout.write("${grid[row][col]} ");
        }
      }
      print("");
    print("");
    }
  }

  int remainingShips() {
    int count = 0;
    for (var row in shipGrid) {
      count += row.where((cell) => cell).length;
    }
    return count;
  }

}