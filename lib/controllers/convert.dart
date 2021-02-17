class Convert implements Exception
{
  final String message;
  Convert(this.message);

  @override
  String toString() {
    return message;
  }
}