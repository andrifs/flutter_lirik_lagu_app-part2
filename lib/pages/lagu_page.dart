import 'package:flutter/material.dart';
import 'package:flutter_lirik_lagu_app/data/datasource/lagu_remote_datasource.dart';
import 'package:flutter_lirik_lagu_app/data/models/lagu_response_model.dart';

class LaguPage extends StatefulWidget {
  const LaguPage({super.key});

  @override
  State<LaguPage> createState() => _LaguPageState();
}

class _LaguPageState extends State<LaguPage> {
  late Future<LaguResponseModel> laguDaerahList;

  @override
  void initState() {
    laguDaerahList = LaguRemoteDatasource().getLaguDaerah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lagu Daerah",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<LaguResponseModel>(
        future: laguDaerahList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data!.data.data[index].judul),
                    subtitle: Text(snapshot.data!.data.data[index].daerah),
                    leading: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.data.data.length,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
