
class NotFoundException {
  final String message;

  NotFoundException({required this.message});

  @override
  String toString() => message;
}