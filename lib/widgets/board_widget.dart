import 'package:campo_minado/models/field.dart';
import 'package:campo_minado/widgets/field_widget.dart';
import 'package:flutter/material.dart';

import 'package:campo_minado/models/board.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.board,
    required this.onOpen,
    required this.onMarkToggle,
  }) : super(key: key);

  final Board board;
  final Function(Field) onOpen;
  final Function(Field) onMarkToggle;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: board.column,
      children: board.fields.map((fields) {
        return FieldWidget(
          field: fields,
          onOpen: onOpen,
          onMarkToggle: onMarkToggle,
        );
      }).toList(),
    );
  }
}
