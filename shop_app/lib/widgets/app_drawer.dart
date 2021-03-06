import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/user_products_screen.dart';
import '../screens/orrders_screen.dart';

class AppDrawer extends StatelessWidget {
  ListTile _buildListTile({IconData icon, String text, Function onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          _buildListTile(
            icon: Icons.shop,
            text: 'Shop',
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          _buildListTile(
            icon: Icons.payment,
            text: 'Orders',
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);

              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (context) => OrdersScreen(),
              //   ),
              // );
            },
          ),
          Divider(),
          _buildListTile(
            icon: Icons.edit,
            text: 'Manage Products',
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UsersProductsScreen.routeName);
            },
          ),
          Divider(),
          _buildListTile(
            icon: Icons.exit_to_app,
            text: 'LogOut',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
