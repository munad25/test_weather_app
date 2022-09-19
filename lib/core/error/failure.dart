class Failure {
  final String  message;
  final String code;
  final Map<String, dynamic>? data;

  const Failure({
    required this.message,
    required this.code,
    this.data,
  });
}