class ApiResponseModel<T> {
  final int? code;
  final T? data;
  final bool success;
  final String? message;

  ApiResponseModel({
    required this.code,
    required this.success,
    this.message,
    this.data,
  });
}
