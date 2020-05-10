import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeDidLoadEvent extends HomeEvent {
  bool _retry = false;

  HomeDidLoadEvent();

  @override
  List<Object> get props => [];

  retryLoad() {
    _retry = true;
  }

  didHomeRetryConnection() {
    return _retry;
  }
}
