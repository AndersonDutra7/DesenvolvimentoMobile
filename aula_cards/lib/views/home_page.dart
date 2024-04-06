import 'package:flutter/material.dart';
import 'package:aula_cards/services/request_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        // Image.network(
                        //   snapshot.data[index]['images'][0],
                        //   width: 300,
                        //   height: 200,
                        //   fit: BoxFit.cover,
                        // ),
                        Image.network(
                            'https://source.unsplash.com/300x220/?phone'),
                        const SizedBox(height: 12),
                        Text('${snapshot.data[index]['title']}'),
                        Text('R\$ ${snapshot.data[index]['price']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
