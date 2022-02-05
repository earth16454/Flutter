import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../model/sub_list.dart';

class NameListProvider with ChangeNotifier {
  // ตัวอย่างข้อมูล
  List<SubList> event = [];

  // ดึงข้อมูล
  List<SubList> getEvent() {
    return event;
  }

  // เพิ่มข้อมูล
  void addEvent(SubList addEvent) {
    //event.add(addEvent); // add เรียงจากเก่าไปใหม่
    // var db = NameListDB(dbName: 'Grocery.db').openDatabase();
    // print(db);
    event.insert(0, addEvent);
    notifyListeners();
  }
}
