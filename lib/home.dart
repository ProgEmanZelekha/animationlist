import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Items in the list
  final _items = [];

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();
 final ScrollController _scrollController =  ScrollController();


  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem() {
    int currentIndex = _items.length;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +300 ,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    _items.insert(currentIndex, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(currentIndex, duration: const Duration(milliseconds: 500));


  }

  // Remove an item
  // This is trigger when the trash icon associated with an item is tapped
  void _removeItem(int index) {
    String item = _items[index];

    _key.currentState!.removeItem(index, (_, animation) {
      return  SizeTransition(
        sizeFactor: animation,
        child:  Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.red,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text(item, style: TextStyle(fontSize: 24)),
          ),
        ),
      );

    }, duration: const Duration(milliseconds: 500));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('challenge3'),
      ),
      body: AnimatedList(
        key: _key,
        controller: _scrollController,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          return SlideTransition(
            key: UniqueKey(),
            // sizeFactor: animation,
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title:
                Text(_items[index], style: const TextStyle(fontSize: 24)),
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _removeItem(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addItem, child: const Icon(Icons.add)),
    );
  }
}
