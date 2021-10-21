import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  //Campo aberto ou fechado
  bool _open = false;
  //Campo está marcado
  bool _marked = false;
  //Campo minado
  bool _mined = false;
  //Campo explodido, mostra o local que gerou a explosão
  bool _explosion = false;

  Field({required this.line, required this.column});

  //Método para indentificar os campos vizinhos,
  //Se a diferença de deltaLine e deltaColumn for igual a 0, significa que é o mesmo campo
  //Se a diferença de de deltaLine e deltaColumn for igual ou menor que 1, seignifica que são campos vizinhos
  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (line - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      return neighbors.add(neighbor);
    }
  }

  //Método para abrir um campo
  void open() {
    if (_open) {
      return;
    }

    //Após aberto open = true;
    _open = true;

    //Método que irá dizer que o campo é minado
    //Após isso será lançada a exceção
    if (_mined) {
      _explosion = true;
      throw ExplosionException();
    }

    //Método para fazer a recursividade e ir abrindo todos os vizinhos que possuam a lógica de não estarem minados
    if (safeNeighborhood) {
      neighbors.forEach((neighbors) => neighbors.open());
    }
  }

  //Método para revelar as bombas quando o jogador perder
  void revealBomb() {
    if (_mined) {
      _open = true;
    }
  }

  //Método para reiniciar o campo
  void reboot() {
    _open = false;
    _marked = false;
    _mined = false;
    _explosion = false;
  }

  //Método para minar o campo
  void mining() {
    _mined = true;
  }

  //Método para alterar uma marcação no campo
  void markToggle() {
    _marked = !_marked;
  }

  //Método para retornar um campo minado ou não
  bool get mined {
    return _mined;
  }

  //Método para retornar um campo explodido
  bool get exploded {
    return _explosion;
  }

  //Método para retornar um campo aberto
  bool get opened {
    return _open;
  }

  //Método para retornar um campo marcado
  bool get marked {
    return _marked;
  }

  //Método retorna a resolução do campo
  bool get solved {
    bool minedAndMarked = mined && marked;
    bool safeAndOpened = !mined && opened;
    return minedAndMarked || safeAndOpened;
  }

  //Método retorna se a vizinhança é segura
  //Every serve pra verificar se todos os vizinho possuem a mesma lógica, ou seja, todos os vizinhos
  //precisam não estar minados para serem abertos de forma recursiva.
  bool get safeNeighborhood {
    return neighbors.every((neighbor) => !neighbor._mined);
  }

  //Método retorna quantidade de minas nos vizinhos
  //Pega os vizinhos minados onde vizinhos neighbor.mined = true
  //e retorna a quantidade no .lenght
  int get qtyNeighborhoodMines {
    return neighbors.where((neighbor) => neighbor.mined).length;
  }
}
