import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final String? message;
  final DioException? error;

  const DataState({this.data, this.message, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data, String message)
      : super(data: data, message: message);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
