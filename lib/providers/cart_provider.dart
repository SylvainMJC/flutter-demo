import 'package:flutter/material.dart';
import '../../bo/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _cartItems = {}; // Stocke l'ID du produit et sa quantité
  final Map<int, Product> _products = {}; // Stocke les produits

  List<Product> getAll() =>
      _cartItems.keys.map((id) => _products[id]!).toList();

  int getQuantity(Product product) => _cartItems[product.id] ?? 0;

  void add(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id] = _cartItems[product.id]! + 1;
    } else {
      _cartItems[product.id] = 1;
      _products[product.id] = product;
    }
    notifyListeners();
  }

  void remove(Product product) {
    if (_cartItems.containsKey(product.id)) {
      if (_cartItems[product.id]! > 1) {
        _cartItems[product.id] = _cartItems[product.id]! - 1;
      } else {
        _cartItems.remove(product.id);
        _products.remove(product.id);
      }
      notifyListeners();
    }
  }

  void clear() {
    _cartItems.clear();
    _products.clear();
    notifyListeners();
  }
}
