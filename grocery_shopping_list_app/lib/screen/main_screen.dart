import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/send.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Box todoListBox;
  @override
  void initState() {
    super.initState();
    todoListBox = Hive.box('ListBox');
  }

  _deleteInfo(int index) {
    todoListBox.deleteAt(index);
    print('Item deleted from box at index: $index');
  }

  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Shopping List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/addScreen');
          });
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.blueGrey[50],
      body: ValueListenableBuilder(
        valueListenable: todoListBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Image.asset('images/shoppingLogo.png'),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Create my Grocery shopping list !!!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var todoData = currentBox.getAt(index)!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      child: ListTile(
                        title: Text(
                          '${todoData.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text('${todoData.time}'),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(
                              context,
                              '/page2',
                              arguments: sendIndex(todoData.name),
                            );
                          });
                        },
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleteInfo(index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
