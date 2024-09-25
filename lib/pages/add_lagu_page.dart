import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lirik_lagu_app/data/datasource/lagu_remote_datasource.dart';
import 'package:image_picker/image_picker.dart';

class AddLaguPage extends StatefulWidget {
  const AddLaguPage({super.key});

  @override
  State<AddLaguPage> createState() => _AddLaguPageState();
}

class _AddLaguPageState extends State<AddLaguPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController laguController = TextEditingController();
  final TextEditingController daerahController = TextEditingController();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lagu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ignore: prefer_const_constructors
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Judul",
              hintText: "Masukan Judul",
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 1.0,
                ),
              ),
            ),
            controller: judulController,
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            keyboardType: TextInputType.text,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Lagu",
              hintText: "Masukan Lagu",
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 1.0,
                ),
              ),
            ),
            controller: laguController,
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Daerah",
              hintText: "Masukan Daerah",
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 1.0,
                ),
              ),
            ),
            controller: daerahController,
          ),
          const SizedBox(
            height: 15,
          ),
          image != null
              ? SizedBox(
                  height: 80,
                  child: Image.file(File(image!.path)),
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  setState(() {});
                },
                child: const Text("Upload gambar"),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gambar wajib diisi"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    await LaguRemoteDatasource().addLaguDaerah(
                      judulController.text,
                      laguController.text,
                      daerahController.text,
                      image!,
                    );
                    judulController.clear();
                    laguController.clear();
                    daerahController.clear();
                    image == null;

                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
