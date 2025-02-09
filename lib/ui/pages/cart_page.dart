import 'package:epsi_shop/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../bo/product.dart';
import '../../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final products = cart.getAll();
    final double total = products.fold<double>(
            0,
            (sum, item) =>
                sum + (item.price.toDouble() * cart.getQuantity(item))) *
        1.2;

    return Scaffold(
      appBar: Navbar(title: "Panier"),
      body: Column(
        children: [
          Expanded(
            child: products.isEmpty
                ? const Center(child: Text("Votre panier est vide"))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final quantity = cart.getQuantity(product);
                      return ListTile(
                        leading:
                            Image.network(product.image, width: 50, height: 50),
                        title: Text(product.title),
                        subtitle: Text("${product.displayPrice()} x $quantity"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () => cart.remove(product),
                            ),
                            Text("$quantity"),
                            IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () => cart.add(product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Total : ${total.toStringAsFixed(2)}€",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                if (products.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      // TODO Potentiellement envoyer la requête d'achât ...
                    },
                    child: const Text("Procéder au paiement"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
