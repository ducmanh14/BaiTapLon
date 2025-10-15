import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product) {
    final index = _items.indexWhere((e) => e["name"] == product["name"]);
    if (index != -1) {
      // đảm bảo quantity tồn tại và là int
      final current = _items[index]["quantity"];
      if (current is int) {
        _items[index]["quantity"] = current + 1;
      } else {
        _items[index]["quantity"] = 1;
      }
    } else {
      _items.add({...product, "quantity": 1});
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalPrice {
    int sum = 0;
    for (var item in _items) {
      // Lấy giá và số lượng một cách an toàn
      final dynamic rawPrice = item["price"];
      final dynamic rawQty = item["quantity"];

      // Chuyển sang num (hỗ trợ int/double) rồi lấy toInt()
      int price = 0;
      int qty = 0;

      if (rawPrice is int) {
        price = rawPrice;
      } else if (rawPrice is double) {
        price = rawPrice.toInt();
      } else if (rawPrice is String) {
        price = int.tryParse(rawPrice) ?? 0;
      } else if (rawPrice is num) {
        price = rawPrice.toInt();
      }

      if (rawQty is int) {
        qty = rawQty;
      } else if (rawQty is double) {
        qty = rawQty.toInt();
      } else if (rawQty is String) {
        qty = int.tryParse(rawQty) ?? 0;
      } else if (rawQty is num) {
        qty = rawQty.toInt();
      }

      sum += price * qty;
    }

    return sum;
  }
  int get totalItems {
    int total = 0;
    for (var item in _items) {
      total += item["quantity"] as int;
    }
    return total;
  }

}
