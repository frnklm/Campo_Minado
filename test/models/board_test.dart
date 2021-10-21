import 'package:campo_minado/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('ganhar o jogo', () {
    Board board = Board(
      line: 2,
      column: 2,
      qtyBombs: 0,
    );

    board.fields[0].mining();
    board.fields[3].mining();

    board.fields[0].markToggle();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].markToggle();

    expect(board.solved, isTrue);
  });
}
