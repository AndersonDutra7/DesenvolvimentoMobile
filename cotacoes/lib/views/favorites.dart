import 'package:flutter/material.dart';
import 'package:cotacoes/views/home.dart';

class FavoritesPage extends StatefulWidget {
  final Set<String> favoriteCurrencies;

  const FavoritesPage({super.key, required this.favoriteCurrencies});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: const Text('Favoritas'),
        leading: IconButton(
          icon: Image.asset('lib/assets/logo.png'),
          onPressed: () {
            Navigator.pop(context, widget.favoriteCurrencies);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
            child: const ListTile(
              title: Text('Minhas Moedas Favoritas'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.favoriteCurrencies.length,
              itemBuilder: (context, index) {
                final currencyCode = widget.favoriteCurrencies.elementAt(index);
                return ListTile(
                  title: Text(currencyCode),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, widget.favoriteCurrencies);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
