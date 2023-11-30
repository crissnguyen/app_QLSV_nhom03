part of 'scoreboard_bloc.dart';

enum ScoreBoardStatus { loading, loaded, success, failure }

class ScoreBoardState extends Equatable {
  final ScoreBoardStatus status;
  final ScoreBoardModel scoreBoard;

  const ScoreBoardState._({
    this.status = ScoreBoardStatus.loading,
    this.scoreBoard = ScoreBoardModel.empty,
  });

  const ScoreBoardState.loading() : this._();

  const ScoreBoardState.loaded({
    required ScoreBoardModel scoreBoard,
  }) : this._(
          status: ScoreBoardStatus.loaded,
          scoreBoard: scoreBoard,
        );

  @override
  List<Object?> get props => [status, scoreBoard];
}
