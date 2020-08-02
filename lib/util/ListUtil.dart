import 'dart:math';

typedef GenerateSeparatorCallback<T> = T Function();

abstract class ListUtil {
  /// Given a [list], return a list where each pair of items has an item between
  /// them, based on the return value of [generateSeparatorCallback]
  static List<T> separate<T>(
      List<T> list, GenerateSeparatorCallback<T> generateSeparatorCallback) {
    List<T> out = List(max((list.length * 2) - 1, 0));
    var outIndex = 0;
    for (var item in list) {
      if (outIndex > 0) {
        out[outIndex++] = generateSeparatorCallback();
      }
      out[outIndex++] = item;
    }
    return out;
  }
}
