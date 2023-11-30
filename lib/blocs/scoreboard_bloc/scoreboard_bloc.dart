// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qlsvnhom3/models/scoreboard_model/scoreboard_model.dart';
import 'package:qlsvnhom3/repositories/scoreboard_repository/scoreboard_repository.dart';

part 'scoreboard_event.dart';
part 'scoreboard_state.dart';

class ScoreBoardBloc extends Bloc<ScoreBoardEvent, ScoreBoardState> {
  ScoreBoardBloc(
      {required String mssv,
      required ScoreBoardRepository scoreBoardRepository})
      : _mssv = mssv,
        _scoreBoardRepository = scoreBoardRepository,
        super(const ScoreBoardState.loading()) {
    on<LoadScoreboard>(_onLoadScoreboard);

    _scoreBoardSubcription = _scoreBoardRepository
        .getScoreBoard(mssv)
        .listen((scoreBoard) => add(LoadScoreboard(scoreBoard)));
  }

  final String _mssv;
  final ScoreBoardRepository _scoreBoardRepository;
  late final StreamSubscription<ScoreBoardModel> _scoreBoardSubcription;

  FutureOr<void> _onLoadScoreboard(
      LoadScoreboard event, Emitter<ScoreBoardState> emit) {
    final scoreBoard = event.scoreBoard;
    if (scoreBoard.isNotEmpty) {
      emit(ScoreBoardState.loaded(scoreBoard: scoreBoard));
    }
  }

  @override
  Future<void> close() {
    _scoreBoardSubcription.cancel();
    return super.close();
  }
}
