import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/minifigure_provider.dart';
import 'edit_screen.dart';

class CollectionScreen extends StatefulWidget{
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  String _searchQuery = "";
  String _collectionFilter = "";

  @override
  Widget build(BuildContext context) {
    final minifigs = context.watch<MinifigureProvider>().items;

    final filtered = minifigs.where((fig) {
      final matchesName = fig.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCollection = _collectionFilter.isEmpty || 
      fig.collection.toLowerCase().contains(_collectionFilter.toLowerCase());
      return matchesName && matchesCollection;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Coleção"),
        backgroundColor: Colors.yellow[700],     
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField( 
              decoration: const InputDecoration(
                labelText: "Pesquisar por nome",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Pesquisar por coleção",
                prefixIcon: Icon(Icons.filter_alt),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _collectionFilter = value;
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: filtered.isEmpty
            ? const Center(
              child: Text (
                "Nenhuma minifigure encontrada!",
                style: TextStyle(fontSize: 18),
              ),
            )
            : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filtered.length,
              itemBuilder: (ctx, i) {
                final fig = filtered[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditScreen(index: i, minifigure: fig),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: fig.imagePath != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.file(
                                    File(fig.imagePath!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.toys, size: 80, color: Colors.amber),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                fig.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                fig.collection,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
