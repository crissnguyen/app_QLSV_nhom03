part of 'scoreboard_bloc.dart';

abstract class ScoreBoardEvent extends Equatable {
  const ScoreBoardEvent();

  @override
  List<Object?> get props => [];
}

class LoadScoreboard extends ScoreBoardEvent {
  final ScoreBoardModel scoreBoard;
  const LoadScoreboard(this.scoreBoard);

  @override
  List<Object?> get props => [scoreBoard];
}
