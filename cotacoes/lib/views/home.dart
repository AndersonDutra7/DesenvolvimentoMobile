import 'package:flutter/material.dart';
import 'package:cotacoes/services/request_http.dart';
import 'package:cotacoes/views/favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  late Map<String, dynamic> _currencyData;
  final Set<String> _favoriteCurrencies = {};

  late List<String> _filteredCurrencies = [];

  @override
  void initState() {
    super.initState();
    _loadCurrencyData();
  }

  Future<void> _loadCurrencyData() async {
    try {
      final Map<String, dynamic> data = await getCurrencyData();
      setState(() {
        _currencyData = data;
        _filteredCurrencies = _currencyData.keys.toList();
      });
    } catch (e) {
      print('Failed to load currency data: $e');
    }
  }

  bool _isFavorite(String currencyCode) {
    return _favoriteCurrencies.contains(currencyCode);
  }

  void _toggleFavorite(String currencyCode) {
    setState(() {
      if (_isFavorite(currencyCode)) {
        _favoriteCurrencies.remove(currencyCode);
      } else {
        _favoriteCurrencies.add(currencyCode);
      }
    });
  }

  void _filterCurrencies(String query) {
    setState(() {
      _filteredCurrencies = _currencyData.keys.where((currency) {
        return currency.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: const Text('Moedas'),
        leading: IconButton(
          icon: Image.asset('lib/assets/logo.png'),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar moedas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              cursorColor: Colors.blue,
              onChanged: _filterCurrencies,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currencyCode = _filteredCurrencies[index];
                final currencyData = _currencyData[currencyCode];
                return Column(
                  children: [
                    ListTile(
                      title: Text(currencyCode),
                      subtitle: Text(currencyData['name']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: _isFavorite(currencyCode)
                              ? Colors.red
                              : const Color.fromARGB(255, 108, 107, 107),
                        ),
                        onPressed: () {
                          _toggleFavorite(currencyCode);
                        },
                      ),
                    ),
                    const Divider(
                      color: Colors.blue,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FavoritesPage(favoriteCurrencies: _favoriteCurrencies)),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.star),
      ),
    );
  }
}
