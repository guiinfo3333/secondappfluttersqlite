import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  'https://images.unsplash.com/photo-1553835973-dec43bfddbeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80'),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _FeatureItem(
                    'Tranfer',
                    Icons.monetization_on,
                    onClick: () {
                      _showContactsList(context);
                    },
                  ),
                  _FeatureItem(
                    'Transaction Feed',
                    Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _showTransactionsList(BuildContext context) {

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}

void _showContactsList(BuildContext context) {
  //funcao para ir para outra rota
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ContactsList()));
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;

  final Function onClick;

  _FeatureItem(this.name, this.icon,
      {@required this.onClick}); //o onclick vai servir justamente para os links

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
              padding: EdgeInsets.all(8.0),
              width: 150,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(icon, color: Colors.white, size: 24.0),
                    Text(name,
                        style: TextStyle(color: Colors.white, fontSize: 16.0))
                  ])),
        ),
      ),
    );
  }
}
