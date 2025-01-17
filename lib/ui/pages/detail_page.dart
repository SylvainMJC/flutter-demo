import 'package:flutter/material.dart';
import '../../bo/product.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Produit")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            product.image,
            width: 100,
            height: 100,
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
          Spacer(),
          ButtunReverserEssai()
        ],
      ),
    );
  }
}

class ButtunReverserEssai extends StatelessWidget {
  const ButtunReverserEssai({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
            ElevatedButton(onPressed: () {}, child: Text("Réserver un essai")),
      ),
    );
  }
}

class TitleAndPriceRow extends StatelessWidget {
  const TitleAndPriceRow({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          product.displayPrice(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ]),
    );
  }
}
