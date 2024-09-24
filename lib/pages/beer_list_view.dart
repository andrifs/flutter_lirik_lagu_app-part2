import 'package:flutter/material.dart';
import 'package:flutter_lirik_lagu_app/data/datasource/lagu_remote_datasource.dart';
import 'package:flutter_lirik_lagu_app/data/models/lagu_response_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  const BeerListView({super.key});

  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  final PagingController<int, Lagu> _pagingController =
      PagingController(firstPageKey: 1);

  final TextEditingController judulController = TextEditingController();
  final TextEditingController laguController = TextEditingController();
  final TextEditingController daerahController = TextEditingController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await LaguRemoteDatasource().getLaguDaerahPages(pageKey);
      final isLastPage = newItems.data.currentPage == newItems.data.lastPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data.data);
      } else {
        _pagingController.appendPage(newItems.data.data, ++pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lagu Daerah',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueAccent,
      ),
      body: PagedListView<int, Lagu>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Lagu>(
          itemBuilder: (context, item, index) {
            return Card(
              child: ListTile(
                title: Text(item.judul),
                subtitle: Text(item.daerah),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add New Lagu'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Judul',
                        ),
                        controller: judulController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Lagu',
                        ),
                        maxLines: 5,
                        controller: laguController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Daerah',
                        ),
                        controller: daerahController,
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        LaguRemoteDatasource().addLaguDaerah(
                          judulController.text,
                          laguController.text,
                          daerahController.text,
                        );
                      },
                      child: const Text('Add'),
                    )
                  ],
                );
              });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
