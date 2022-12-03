import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/movies_item.dart';
import 'package:note_app/show_note_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  /// defined a variable for collection name
  final _collectionName = 'myNotes';

  /// defined a variable for titlelength
  final _titleLength = 40;

  /// defined a variable for textlength
  final _textLength = 50;

  /// defined a variable for appbar title
  final _appbarTitle = 'My Notes';

  /// a list for myNotes items
  List<MItem> m_items = [];

  @override
  void initState() {
    // TODO: implement initState
    dataFetch();
    FirebaseFirestore.instance
        .collection(_collectionName)
        .snapshots()
        .listen((records) {
      mapDatas(records);
    });
    super.initState();
  }

  /// data fetching
  dataFetch() async {
    var records =
        await FirebaseFirestore.instance.collection(_collectionName).get();
    mapDatas(records);
  }
  /// a method for map to list convert
  mapDatas(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) => MItem(
            id: item.id,
            title: item['title'],
            text: item['text'],
            date: item['date'],
            time: item['time']))
        .toList();

    setState(() {
      m_items = list;
    });
  }

  /// a method for add item 
  addItem(String name, String year, String date, String time) {
    var newM = MItem(id: name, title: name, text: year, date: date, time: time);
    FirebaseFirestore.instance.collection(_collectionName).add(newM.toJson());
  }
  
  /// a method for delete item 
  deleteItem(String id) {
    FirebaseFirestore.instance.collection(_collectionName).doc(id).delete();
  }
  
  /// a method for update item 
  updateItem(String id, String name, String year, String date, String time) {
    var updatenew =
        MItem(id: name, title: name, text: year, date: date, time: time);
    FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(id)
        .update(updatenew.toJson());
  }
  

  showAddDialog() {
    var titleController = TextEditingController();
    var textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Text(
                      'Add new Note',
                      style: TextStyle(color: Colors.black38, fontSize: 20),
                    ))),
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    )),
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: null,
                      controller: textController,
                      decoration: InputDecoration(labelText: 'Text'),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange),
                          onPressed: () {
                            addItem(
                                titleController.text,
                                textController.text,
                                DateFormat('dd / MM / yyyy')
                                    .format(DateTime.now()),
                                DateFormat('kk:mm:ss').format(DateTime.now()));

                            Navigator.pop(context);
                          },
                          child: Text('Add Item')),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  /// a method for display just first 40 lines in subtitle area
String showSubtitle(String data) {
  String newLine = "";
  if (data.length > _textLength) {
    for (var i = 0; i < 40; i++) {
      newLine = newLine + '${data[i]}';
    }
    newLine = newLine + " ...";
  } else {
    for (var i = 0; i < data.length; i++) {
      newLine = newLine + '${data[i]}';
    }
  }

  return newLine;
}

/// a method for display just first 50 lines in title area
String showTitle(String title) {
  String newLine = "";
  if (title.length > _titleLength) {
    for (var i = 0; i < 50; i++) {
      newLine = newLine + '${title[i]}';
    }
    newLine = newLine + " ...";
  } else {
    for (var i = 0; i < title.length; i++) {
      newLine = newLine + '${title[i]}';
    }
  }

  return newLine;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /// floating action button for adding item
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            showAddDialog();
          },
        ),
        appBar: AppBar(
            title: Text(_appbarTitle),
            centerTitle: true,
            backgroundColor: Colors.orange),
        body: ListView.builder(
            itemCount: m_items.length,
            itemBuilder: ((context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowNote(m_items[index]))); 
                  },
                  title: Text(showTitle(m_items[index].title)),
                  subtitle: Text(showSubtitle(m_items[index].text) +
                      "\n" +
                      "                                                                                          " +
                      m_items[index].time.toString() +
                      "\n" +
                      "                                                                                " +
                      m_items[index].date.toString()),
                ),
              );
            })));
  }
}

