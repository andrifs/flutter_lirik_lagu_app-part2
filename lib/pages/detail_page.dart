// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_lirik_lagu_app/data/models/lirik_lagu.dart';

class DetailPage extends StatefulWidget {
  final LirikLagu lirikLagu;
  const DetailPage({
    super.key,
    required this.lirikLagu,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lirikLagu.judulLagu),
        elevation: 2,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${widget.lirikLagu.namaBand} - ${widget.lirikLagu.judulLagu}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Image.network(
            widget.lirikLagu.photo,
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
              widget.lirikLagu.lirikLagu,
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
