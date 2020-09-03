import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test("Ganhar jogo", () {
    Tabuleiro tabuleiro = Tabuleiro(
      linhas: 2,
      colunas: 2,
      qtdeBombas: 0,
    );
    //minando uma bomba
    tabuleiro.campos[0].minar();
    tabuleiro.campos[3].minar();

    //jOGANDO...
    tabuleiro.campos[0].alteranarMarcacao();
    tabuleiro.campos[1].abrir();
    tabuleiro.campos[2].abrir();
    tabuleiro.campos[3].alteranarMarcacao();

    expect(tabuleiro.resolvido, isTrue);
  });
}
