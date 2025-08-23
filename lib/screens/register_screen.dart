// lib/screens/register_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import '../models/minifigure.dart';
import '../providers/minifigure_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _collectionController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newMinifigure = Minifigure(
        name: _nameController.text,
        collection: _collectionController.text,
        imagePath: _imageFile?.path,
      );

      Provider.of<MinifigureProvider>(context, listen: false)
      .addMinifigure(newMinifigure);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minifigure registrada!')),
      );

      // limpa os campos depois de salvar
      _nameController.clear();
      _collectionController.clear();
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Minifigure'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campo Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Digite o nome' : null,
                ),
                const SizedBox(height: 16),

                // Campo Coleção
                TextFormField(
                  controller: _collectionController,
                  decoration: const InputDecoration(
                    labelText: 'Coleção',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Digite a coleção' : null,
                ),
                const SizedBox(height: 16),

                // Imagem
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : const Text("Nenhuma foto selecionada"),

                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Tirar Foto"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                  ),
                ),

                const SizedBox(height: 24),

                // Botão salvar
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.yellow[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                  ),
                  child: const Text("Salvar Minifigure"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
