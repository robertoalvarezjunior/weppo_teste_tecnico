import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'grid_event.dart';
part 'grid_state.dart';

final class GridBloc extends Bloc<GridEvent, GridState> {
  GridBloc() : super(EmptyGridState()) {
    on<GetGridEvent>(_getGrid);
    on<GetGridMenorEvent>(_getGridMenor);
  }

  void _getGridMenor(GetGridMenorEvent event, Emitter<GridState> emit) async {
    emit(CarregandoGridState());

    try {
      final dados = await rootBundle.loadString('assets/menor_input.txt');

      if (dados.isEmpty) {
        emit(EmptyGridState());
        return;
      }

      final linhas = dados.split('\n').map((linha) => linha.trim()).toList();

      final marcacao = await Isolate.run(() => _marcarXMAS(linhas));

      emit(CarregadoGridState(marcacao));
    } catch (e) {
      emit(ErrorGridState(e.toString()));
      log(e.toString());
    }
  }

  void _getGrid(GetGridEvent event, Emitter<GridState> emit) async {
    emit(CarregandoGridState());

    try {
      final dados = await rootBundle.loadString('assets/input.txt');

      if (dados.isEmpty) {
        emit(EmptyGridState());
        return;
      }

      final linhas = dados.split('\n').map((linha) => linha.trim()).toList();

      final marcacao = await Isolate.run(() => _marcarXMAS(linhas));

      emit(CarregadoGridState(marcacao));
    } catch (e) {
      emit(ErrorGridState(e.toString()));
      log(e.toString());
    }
  }

  static List<List<String>> _marcarXMAS(List<String> grid) {
    final int linhas = grid.length;
    final int colunas = grid[0].length;
    const palavra = "XMAS";

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

    // Inicializa matriz com "."
    List<List<String>> marcada = List.generate(
      linhas,
      (i) => List.filled(colunas, '.', growable: false),
      growable: false,
    );

    // Passo em cada linha
    for (int i = 0; i < linhas; i++) {
      // Verifica cada letra
      for (int j = 0; j < colunas; j++) {
        // verifica cada direção
        for (var dir in direcoes) {
          int linha = i;
          int coluna = j;
          bool match = true;
          List<List<int>> indices = [];

          // Verifica cada letra da palavra
          for (int k = 0; k < palavra.length; k++) {
            // se for fora da matriz termina o loop
            if (linha < 0 ||
                linha >= linhas ||
                coluna < 0 ||
                coluna >= colunas) {
              match = false;
              break;
            }

            // se a letra for diferente da palavra termina o loop
            if (grid[linha][coluna] != palavra[k]) {
              match = false;
              break;
            }

            //adiciona o indice em que a letra foi encontrada
            indices.add([linha, coluna]);
            //passa para a proxima letra da linha
            linha += dir[0];
            //passa para a proxima letra da coluna
            coluna += dir[1];
          }

          if (match) {
            // Marca as letras da palavra na matriz de saída
            for (var idx in indices) {
              marcada[idx[0]][idx[1]] = grid[idx[0]][idx[1]];
            }
          }
        }
      }
    }

    return marcada;
  }
}
