import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/explosion_exception.dart';
import 'package:campo_minado/widgets/board_widget.dart';
import 'package:flutter/material.dart';
import 'package:campo_minado/widgets/result_widget.dart';
import 'package:campo_minado/models/field.dart';

class MineFieldApp extends StatefulWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  @override
  State<MineFieldApp> createState() => _MineFieldAppState();
}

class _MineFieldAppState extends State<MineFieldApp> {
  bool? _win;
  Board? _board;

  void _reboot() {
    setState(() {
      _win = null;
      _board!.reboot();
    });
  }

  void _open(Field field) {
    setState(() {
      try {
        field.open();
        if (_board!.solved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _board!.revealBombs();
      }
    });
  }

  void _markToggle(Field field) {
    if (_win != null) {
      return;
    }

    setState(() {
      field.markToggle();
      if (_board!.solved) {
        _win = true;
      }
    });
  }

  Board _getBoard(double width, double heigh) {
    if (_board == null) {
      int qtyColumn = 15;
      double fieldSize = width / qtyColumn;
      int qtyLine = (heigh / fieldSize).floor();

      _board = Board(
        line: qtyLine,
        column: qtyColumn,
        qtyBombs: 50,
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          win: _win,
          onReboot: _reboot,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onMarkToggle: _markToggle,
              );
            },
          ),
        ),
      ),
    );
  }
}
