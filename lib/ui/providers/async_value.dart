class AsyncValue<T> {
  final T? data;
  final Object? error;
  final bool isLoading;

  AsyncValue._({this.data, this.error, this.isLoading = false});

  factory AsyncValue.loading() => AsyncValue._(isLoading: true);

  factory AsyncValue.success(T data) => AsyncValue._(data: data);

  factory AsyncValue.error(Object error) => AsyncValue._(error: error);

  bool get isSuccess => data != null && !isLoading && error == null;
  bool get hasError => error != null;
}