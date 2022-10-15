import 'package:compos_interview/model/welcome.dart';

class Cart {
  List<Welcome> _items = [];
  double total = 0;
  add_item(Welcome item) {
    _items.add(item);
    total += item.price;
  }

  get_item(int index) {
    return _items[index];
  }

  contains(Welcome item) {
    return _items.contains(item);
  }

  length() {
    return _items.length;
  }

  remove(Welcome item) {
    total -= item.price;
    _items.remove(item);
  }
}
