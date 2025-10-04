enum StateType { initial, loading, loaded, error }

extension StateTypeX on StateType {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() loaded,
    required T Function() error,
  }) {
    switch (this) {
      case StateType.initial:
        return initial();
      case StateType.loading:
        return loading();
      case StateType.loaded:
        return loaded();
      case StateType.error:
        return error();
    }
  }
}