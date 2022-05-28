class AppException implements Exception {
  AppException(
      {required this.message, required this.prefix, required this.code});

  final int code;
  final String message;
  final String prefix;

  @override
  String toString() {
    return '$code: $prefix$message';
  }
}

class ServerException extends AppException {
  ServerException(
    String message,
    String prefix, {
    int code = 400,
  }) : super(message: message, prefix: prefix, code: code);

  @override
  String get message;
  @override
  String get prefix;
  @override
  int get code;
}
