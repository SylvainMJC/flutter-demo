import 'package:epsi_shop/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../bo/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../providers/cart_provider.dart';

class ListProductsPage extends StatelessWidget {
  ListProductsPage({super.key});

  Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> listMapProducts = jsonDecode(response.body);
      return listMapProducts.map((e) => Product.fromMap(e)).toList();
    } else {
      throw Exception('Échec du chargement des produits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: "EPSI Shop"),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Erreur : ${snapshot.error}",
                    style: const TextStyle(fontSize: 18, color: Colors.red)));
          } else if (snapshot.hasData) {
            final listProducts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: listProducts.length,
              itemBuilder: (context, index) {
                final product = listProducts[index];
                return InkWell(
                  onTap: () => context.go("/detail/${product.id}"),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Hero(
                        tag: product.image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product.displayPrice(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Aucun produit disponible"));
          }
        },
      ),
    );
  }
}
