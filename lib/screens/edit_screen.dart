import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/minifigure.dart';
import '../providers/minifigure_provider.dart';

class EditScreen extends StatefulWidget {
  final int index;
  final Minifigure minifigure;

  const EditScreen({
    super.key,
    required this.index,
    required this.minifigure,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _collectionController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.minifigure.name);
    _collectionController = TextEditingController(text: widget.minifigure.collection);
    if(widget.minifigure.imagePath != null){
      _imageFile = File(widget.minifigure.imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if(pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final updated = Minifigure(
        name: _nameController.text,
        collection: _collectionController.text,
        imagePath: _imageFile?.path,
      );

      Provider.of<MinifigureProvider>(context, listen: false)
      .updateMinifigure(widget.index, updated);

      Navigator.pop(context);
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Minifigure"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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

                _imageFile != null
                    ? Image.file(_imageFile!, height: 200, fit: BoxFit.cover)
                    : const Text("Nenhuma foto selecionada"),

                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Trocar Foto"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.yellow[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: const Text("Salvar Alterações"),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<MinifigureProvider>(context, listen: false)
                    .deleteMinifigure(widget.index);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Excluir Minifigure"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}