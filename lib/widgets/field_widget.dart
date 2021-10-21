import 'package:flutter/material.dart';
import 'package:campo_minado/models/field.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    Key? key,
    required this.field,
    required this.onOpen,
    required this.onMarkToggle,
  }) : super(key: key);

  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onMarkToggle;

  //Método recebe a imagem baseado na situação atual do campo
  Widget _getImage() {
    
    int qtyMines = field.qtyNeighborhoodMines;

    if (field.opened && field.mined && field.exploded) {
      return Image.asset('lib/assets/images/bomba_0.jpeg');
    } else if (field.opened && field.mined) {
      return Image.asset('lib/assets/images/bomba_1.jpeg');
    } else if (field.opened) {
      return Image.asset('lib/assets/images/aberto_$qtyMines.jpeg');
    } else if (field.marked) {
      return Image.asset('lib/assets/images/bandeira.jpeg');
    } else {
      return Image.asset('lib/assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onMarkToggle(field),
      child: _getImage(),
    );
  }
}
