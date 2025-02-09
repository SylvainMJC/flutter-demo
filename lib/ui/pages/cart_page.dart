import 'package:epsi_shop/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../bo/product.dart';
import '../../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<void> sendPurchaseRequest(
      BuildContext context, List<Product> products, double total) async {
    final url = Uri.parse('https://ptsv3.com/t/EPSISHOPC1/');
    final List<Map<String, dynamic>> items = products
        .map((product) => {
              "id": product.id,
              "title": product.title,
              "price": product.price,
              "quantity": product.price,
            })
        .toList();

    final body = jsonEncode({
      "products": items,
      "total": total.toStringAsFixed(2),
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        context.read<CartProvider>().clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Achat effectué avec succès! Panier vidé.")),
        );
      }
    } catch (e) {
      print("Erreur lors de l'envoi de la requête d'achat: $e");
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: products.isEmpty
                  ? const Center(
                      child: Text(
                        "Votre panier est vide",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final quantity = cart.getQuantity(product);
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              product.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle:
                                Text("${product.displayPrice()} x $quantity"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.redAccent),
                                  onPressed: () => cart.remove(product),
                                ),
                                Text(
                                  "$quantity",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle,
                                      color: Colors.green),
                                  onPressed: () => cart.add(product),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Total : ${total.toStringAsFixed(2)}€",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (products.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () =>
                            sendPurchaseRequest(context, products, total),
                        child: const Text("Procéder au paiement"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
