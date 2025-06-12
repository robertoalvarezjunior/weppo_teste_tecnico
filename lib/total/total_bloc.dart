import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TotalCubit extends Cubit<int> {
  TotalCubit() : super(0);

  void calculaTotalXMAS() async {
    final dados = await rootBundle.loadString('assets/input.txt');
    final linhas = dados.split('\n').map((linha) => linha.trim()).toList();

    final total = _totalXMAS(linhas);

    emit(total);
  }

  static int _totalXMAS(List<String> grid) {
    final int linhas = grid.length;
    final int colunas = grid[0].length;
    const palavra = "XMAS";

    int total = 0;
    final direcoes = [
      [0, 1], // direita
      [1, 0], // baixo
      [0, -1], // esquerda
      [-1, 0], // cima
      [1, 1], // diagonalBaixoDireita
      [1, -1], // diagonalBaixoEsquerda
      [-1, -1], // diagonalCimaEsquerda
      [-1, 1], // diagonalCimaDireita
    ];

    // Passo em cada linha
    for (int i = 0; i < linhas; i++) {
      // Verifica cada letra
      for (int j = 0; j < colunas; j++) {
        // verifica cada direção
        for (var dir in direcoes) {
          int linha = i;
          int coluna = j;
          bool match = true;

          // Verifica cada letra da palavra
          for (int k = 0; k < palavra.length; k++) {
            // se for fora da matriz termina o loop
            if (linha < 0 ||
                linha >= linhas ||
                coluna < 0 ||
                coluna >= colunas ||
                grid[linha][coluna] != palavra[k]) {
              match = false;
              break;
            }

            //passa para a proxima letra da linha
            linha += dir[0];
            //passa para a proxima letra da coluna
            coluna += dir[1];
          }

          if (match) {
            total++;
          }
        }
      }
    }

    return total;
  }
}
