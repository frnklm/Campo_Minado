import 'dart:math';

import 'field.dart';

class Board {
  final int line;
  final int column;
  final int qtyBombs;
  final List<Field> _fields = [];

  Board({
    required this.line,
    required this.column,
    required this.qtyBombs,
  }) {
    _createFields();
    _createNeighborhood();
    _drawMines();
  }

  //Método para reiniciar o tabuleiro
  void reboot() {
    _fields.forEach((fields) => fields.reboot());
    _drawMines();
  }

  //Método para revelar as bombas
  void revealBombs() {
    // ignore: avoid_function_literals_in_foreach_calls
    _fields.forEach((fields) => fields.revealBomb());
  }

  //Método para gerar as linhas e colunas do tabuleiro
  void _createFields() {
    for (int l = 0; l < line; l++) {
      for (int c = 0; c < column; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  //Método para relacionar os vizinhos
  void _createNeighborhood() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  //Método para sortear as minas
  //Vai testar se a quantidade de minhas é menor que quantidade de campos do tabuleiro
  //Enquanto a quantidade de casas sorteadas for menos que as bombas vai continuar minando o tabuleiro
  void _drawMines() {
    int drawn = 0;

    if (qtyBombs > line * column) {
      return;
    }

    while (drawn < qtyBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        drawn++;
        _fields[i].mining();
      }
    }
  }

  //Método para retornar os campos
  List<Field> get fields {
    return _fields;
  }

  bool get solved {
    return _fields.every((fields) => fields.solved);
  }
}
