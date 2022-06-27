class ItemIsNotExistException implements Exception {
  final String item;

  ItemIsNotExistException(this.item) : super();

  @override
  String toString() {
    return "$itemは存在しません。";
  }
}
