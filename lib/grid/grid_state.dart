part of 'grid_bloc.dart';

sealed class GridState {}

final class EmptyGridState extends GridState {}

final class CarregandoGridState extends GridState {}

final class CarregadoGridState extends GridState {
  final List<List<String>> grid;

  CarregadoGridState(this.grid);
}

final class ErrorGridState extends GridState {
  final String message;

  ErrorGridState(this.message);
}
