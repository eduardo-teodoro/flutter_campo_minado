import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/resultado_widget.dart';
import '../components/campo_widget.dart';
import '../models/campo.dart';
import '../models/explosao_exception.dart';

class CampoMinadoApp extends StatefulWidget {
  //metodos
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;

//  Tabuleiro _tabuleiro = Tabuleiro(
//    linhas: 12,
//    colunas: 12,
//    qtdeBombas: 3,
//  );

  Tabuleiro _tabuleiro;

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    //se venceu ou perdeu, não é possivel fazer mais nada
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    //se venceu ou perdeu, não é possivel fazer mais nada
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alteranarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  //definindo o tabuleiro
  Tabuleiro _getTabuleiro(double largura, double altura) {
    //se o tabuleiro estiver nulo, ele é criado
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      //definindo a quantidade de linhas
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro =
          Tabuleiro(linhas: qtdeLinhas, colunas: qtdeColunas, qtdeBombas: 20);
    }
    return _tabuleiro;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(
                      constraints.maxWidth, constraints.maxHeight),
                  onAbrir: _abrir,
                  onAlternarMarcacao: _alternarMarcacao,
                );
              },
            )),
      ),
    );
  }
}
