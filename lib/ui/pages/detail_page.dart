import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../bo/product.dart';
import '../../providers/cart_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/navbar.dart';

class DetailPage extends StatefulWidget {
  final int idProduct;

  DetailPage({super.key, required this.idProduct});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Product> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = fetchProduct(widget.idProduct);
  }

  Future<Product> fetchProduct(int id) async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Échec du chargement du produit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: "Produit n° ${widget.idProduct}"),
      body: FutureBuilder<Product>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: product.image,
                  child: Image.network(
                    product.image,
                    width: 100,
                    height: 100,
                  ),
                ),
                TitleAndPriceRow(product: product),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    '${product.description} ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Text(
                  'Catégorie : ${product.category}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartProvider>().add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Produit ajouté au panier")),
                    );
                  },
                  child: const Text("Ajouter au panier"),
                ),
                const SizedBox(height: 10),
                const ButtunReverserEssai()
              ],
            );
          } else {
            return const Center(child: Text("Produit introuvable"));
          }
        },
      ),
    );
  }
}

class ButtunReverserEssai extends StatelessWidget {
  const ButtunReverserEssai({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: () {}, child: const Text("Réserver un essai")),
      ),
    );
  }
}

class TitleAndPriceRow extends StatelessWidget {
  const TitleAndPriceRow({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            product.title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            product.displayPrice(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
