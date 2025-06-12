import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weppo_flutter/grid/grid_bloc.dart';
import 'package:weppo_flutter/total/total_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weppo Flutter"),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () => context.read<TotalCubit>().calculaTotalXMAS(),
        //     child: Text('Retorna total de XMAS'),
        //   ),
        //   ElevatedButton(
        //     onPressed: () => context.read<GridBloc>().add(GetGridEvent()),
        //     child: Text('Grid view de XMAS'),
        //   ),
        //   ElevatedButton(
        //     onPressed: () => context.read<GridBloc>().add(GetGridMenorEvent()),
        //     child: Text('Grid view menor de XMAS'),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OverflowBar(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<TotalCubit>().calculaTotalXMAS(),
                  child: Text('Retorna total de XMAS'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<GridBloc>().add(GetGridEvent()),
                  child: Text('Grid view de XMAS'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<GridBloc>().add(GetGridMenorEvent()),
                  child: Text('Grid view menor de XMAS'),
                ),
              ],
            ),
            BlocBuilder<TotalCubit, int>(
              builder: (context, state) => Text(
                'Total: $state',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                ),
              ),
            ),
            BlocBuilder<GridBloc, GridState>(
              builder: (context, state) {
                return switch (state) {
                  EmptyGridState() => const Center(
                    child: Text(
                      "Ao gerar o grid, esperar um pouco. 19k linhas e 19k colunas. Pode travar o emulador.",
                    ),
                  ),
                  CarregandoGridState() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  CarregadoGridState() => Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: state.grid[0].length,
                        mainAxisSpacing: .5,
                        crossAxisSpacing: .5,
                      ),
                      itemCount: state.grid.length * state.grid[0].length,
                      itemBuilder: (context, index) {
                        final letras = state.grid
                            .expand((linha) => linha)
                            .toList();

                        return Container(
                          color: letras[index] != '.'
                              ? Colors.black
                              : Colors.grey,
                          alignment: Alignment.center,
                          child: state.grid.length > 11
                              ? Text('')
                              : Text(
                                  letras[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                        );
                      },
                    ),
                  ),
                  ErrorGridState() => Center(child: Text(state.message)),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
