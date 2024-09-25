import 'package:flutter/material.dart';
import 'package:flutter_lirik_lagu_app/data/datasource/lagu_remote_datasource.dart';
import 'package:flutter_lirik_lagu_app/data/models/lagu_response_model.dart';
import 'package:flutter_lirik_lagu_app/pages/add_lagu_page.dart';
import 'package:flutter_lirik_lagu_app/pages/lagu_detail_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  const BeerListView({super.key});

  @override
  _BeerListViewState createState() => _BeerListViewState();
}

class _BeerListViewState extends State<BeerListView> {
  final PagingController<int, Lagu> _pagingController =
      PagingController(firstPageKey: 1);

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

  Future<void> _refreshPage() async {
    _pagingController.refresh();
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
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LaguDetailPage(lagu: item);
                }));
              },
              child: Card(
                child: ListTile(
                  title: Text(item.judul),
                  subtitle: Text(item.daerah),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        '${LaguRemoteDatasource.imageUrl}/${item.imageUrl}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddLaguPage();
          }));
          await _refreshPage();
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
