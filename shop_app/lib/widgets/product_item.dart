import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authDate = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(authDate.token, authDate.userId);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
