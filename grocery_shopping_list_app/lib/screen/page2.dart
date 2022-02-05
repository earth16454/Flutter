import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../model/send.dart';
import '../model/sub_list.dart';
import '../providers/sublist_provider.dart';

class Page2 extends StatefulWidget {
  static const routeName = '/page2';

  final String? title;
  const Page2({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String? model;
  String? listItemName;
  int selectNum = 0;

  var itemsList = [];

  @override
  void initState() {
    super.initState();
    model = widget.title;
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          color: Colors.green,
          iconSize: 28,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  child: Text(
                    '$model',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // เพิ่มรายการ
            Container(
              width: MediaQuery.of(context).size.width - 12,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: const Text(
                  'Add item',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/add_page2',
                        arguments: sendIndex(model));
                  });
                },
              ),
            ),
            SizedBox(height: 12.0),
            // รอเพิ่ม
            Consumer(
              builder: (context, NameListProvider provider, child) {
                var count = provider.event.length;
                if (count <= 0) {
                  return Container();
                } else {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        height: 590,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (context, index) {
                              SubList data = provider.event[index];
                              return checkBox(data);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text('$selectNum'),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget checkBox(SubList data) {
    return Card(
      child: ListTile(
        leading: data.isSelected
            ? Icon(
                Icons.check_box,
                color: Colors.green,
              )
            : Icon(
                Icons.check_box_outline_blank,
                color: Colors.green,
              ),
        // leading: Icon(
        //   Icons.check_box_outline_blank,
        //   color: Colors.green,
        // ),
        title: Text(
          "${data.sub_Name}  (${data.quantity})",
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text("${data.notes} "),
        trailing: Text("${data.unit_Price} "),
        onTap: () {
          setState(() {
            data.isSelected = !data.isSelected;
            if (data.isSelected == true) {
              selectNum++;
            } else {
              selectNum--;
            }
          });
        },
        dense: true,
      ),
    );
  }
}
