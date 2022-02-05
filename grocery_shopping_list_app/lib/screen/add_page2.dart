import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shopping_list_app/model/sub_list.dart';
import '../providers/sublist_provider.dart';

class AddPage2 extends StatefulWidget {
  static const routeName = '/add_page2';
  final String? title;
  const AddPage2({Key? key, required this.title}) : super(key: key);

  @override
  _AddPage2State createState() => _AddPage2State();
}

class _AddPage2State extends State<AddPage2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String? model;
  @override
  void initState() {
    super.initState();
    model = widget.title;
  }

  var _formKey = GlobalKey<FormState>();

  String? check_TextFormField(String? input_TextFormField) {
    if (input_TextFormField!.isEmpty) {
      textError = "*** Please complete the information ***";
      return null;
    } else {
      textError = "";
    }
    return null;
  }

  String textError = "";

  int num_Quantity = 0;
  double num_UnitPrice = 0;

  remove_Quantity() {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.green[400]),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  if (num_Quantity > 0) {
                    num_Quantity--;
                  }
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              '$num_Quantity',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  num_Quantity++;
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }

  void submit(String name, int quantity, String unit_price, String note) {
    SubList sublist = SubList(
      sub_Name: name,
      quantity: quantity,
      unit_Price: double.parse(unit_price),
      notes: note,
      isSelected: false,
    );
    // เรียก Provider
    var provider = Provider.of<NameListProvider>(context, listen: false);
    provider.addEvent(sublist);
    print('Ok');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.green),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    child: Text(
                      'Test',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              Container(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Card(
                          child: TextFormField(
                            validator: check_TextFormField,
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Item',
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Quantity:'),
                                SizedBox(width: 8),
                                remove_Quantity(),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Unit Price:'),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Card(
                                    child: TextFormField(
                                      controller: priceController,
                                      validator: check_TextFormField,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: '0.00',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text('\$'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text('Note:'),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: noteController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'Note',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            textError,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                bool pass = _formKey.currentState!.validate();
                                if (pass) {
                                  if (nameController == "" ||
                                      num_Quantity == 0 ||
                                      priceController == "") {
                                    textError =
                                        "*** Please complete the information ***";
                                    print('Null');
                                  } else {
                                    textError = "";
                                    print('Submit Pass!');
                                    submit(
                                      nameController.text,
                                      num_Quantity,
                                      priceController.text,
                                      noteController.text,
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
