// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lirik_lagu_app/data/datasource/lagu_remote_datasource.dart';
import 'package:flutter_lirik_lagu_app/data/models/lagu_response_model.dart';
import 'package:flutter_lirik_lagu_app/pages/beer_list_view.dart';
import 'package:image_picker/image_picker.dart';

class LaguDetailPage extends StatefulWidget {
  final Lagu lagu;
  const LaguDetailPage({
    super.key,
    required this.lagu,
  });

  @override
  State<LaguDetailPage> createState() => _LaguDetailPageState();
}

class _LaguDetailPageState extends State<LaguDetailPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController laguController = TextEditingController();
  final TextEditingController daerahController = TextEditingController();

  XFile? image;

  @override
  void initState() {
    judulController.text = widget.lagu.judul;
    laguController.text = widget.lagu.lagu;
    daerahController.text = widget.lagu.daerah;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lagu.judul),
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Lirik Lagu'),
                      content: const Text('Apa anda yakin akan menghapusnya ?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tidak'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await LaguRemoteDatasource()
                                .deleteLaguDaerah(widget.lagu.id);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const BeerListView();
                            }));
                          },
                          child: const Text('Ya'),
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.delete_forever),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text('Edit New Lagu'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              widget.lagu.imageUrl != null && image == null
                                  ? SizedBox(
                                      height: 200,
                                      child: Image.network(
                                          '${LaguRemoteDatasource.imageUrl}/${widget.lagu.imageUrl}'),
                                    )
                                  : const SizedBox(),
                              image != null
                                  ? SizedBox(
                                      height: 200,
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
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
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
                              await LaguRemoteDatasource().updateLaguDaerah(
                                widget.lagu.id,
                                judulController.text,
                                laguController.text,
                                daerahController.text,
                                image!,
                              );
                              judulController.clear();
                              laguController.clear();
                              daerahController.clear();
                              image == null;
                              // await _refreshPage();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const BeerListView();
                              }));
                            },
                            child: const Text('Update'),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${widget.lagu.judul} - ${widget.lagu.daerah}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          widget.lagu.imageUrl == null
              ? const SizedBox(
                  height: 12,
                )
              : Image.network(
                  '${LaguRemoteDatasource.imageUrl}/${widget.lagu.imageUrl!}',
                  height: 300,
                ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 227, 222, 222),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              widget.lagu.lagu,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
