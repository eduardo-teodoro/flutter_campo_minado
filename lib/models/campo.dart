//para usar o decorator
import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

//constantes
  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

//construtor
  Campo({
    @required this.linha,
    @required this.coluna,
  });

//função para adicionar vizinhos
  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    //se os dois forem 0 quer dizer que é o mesmo campo
    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    //quer dizer que é vizinho
    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

//método para abrir uma bomba
  void abrir() {
    if (_aberto) {
      return;
    }
    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }
    //recursividade para abrir os vizinhos
    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  void revelarBombas() {
    if (_minado) {
      _aberto = true;
    }
  }

//marca como true
  void minar() {
    _minado = true;
  }

  //mátodo para alterar a marcação no click longo
  void alteranarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((v) => !v.minado);
  }

//retorna a quantidade de minas
  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((v) => v.minado).length;
  }
}
