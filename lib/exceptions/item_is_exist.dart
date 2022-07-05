class ItemIsExistException implements Exception {
  final String item;

  ItemIsExistException(this.item) : super();

  @override
  String toString() {
    return "$itemは既に存在しています。";
  }
}
