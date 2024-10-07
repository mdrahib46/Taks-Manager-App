class NetworkResponse {
  final bool isSuccess;
  dynamic responseData;
  String errorMessage;
  final int statusCode;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}
