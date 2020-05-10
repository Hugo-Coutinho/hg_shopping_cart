abstract class HomeEvent  {
}

class HomeDidLoadEvent extends HomeEvent {
  bool _retry = false;

  retryLoad() {
    _retry = true;
  }

  didHomeRetryConnection() {
    return _retry;
  }
}
