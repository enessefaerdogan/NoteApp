import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/movies_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowNote extends StatefulWidget {
  /// a item that i sent from main page
  MItem itt;
  ShowNote(this.itt);

  @override
  State<ShowNote> createState() => _ShowNoteState(itt);
}

class _ShowNoteState extends State<ShowNote> {
  MItem itt;
  /// constructor
  _ShowNoteState(this.itt);

   /// defined a variable for collection name
  final _collectionName = 'myNotes';

  String _titleTemp = "";
  String _textTemp = "";

  var titleController = TextEditingController();

  var textController = TextEditingController();
  
  
  List<MItem> m_items = [];

  @override
  void initState() {
    dataFetch();
    FirebaseFirestore.instance
        .collection(_collectionName)
        .snapshots()
        .listen((records) {
      mapDatas(records);
    });
    super.initState();
    _titleTemp = itt.title;
    _textTemp = itt.text;
  }

  /// a method for data fetch
  dataFetch() async {
    var records = await FirebaseFirestore.instance.collection(_collectionName).get();
    mapDatas(records);
  }
  
  /// a method for convert process map to list
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
   
  /// a method for delete item
  deleteData(String id) {
    FirebaseFirestore.instance.collection(_collectionName).doc(id).delete();
  }
 
  /// a method for update item
  updateData(String verititle, String veritext) {
    var updatedItem = MItem(
        id: itt.id,
        title: verititle,
        text: veritext,
        date: DateFormat('dd / MM / yyyy').format(DateTime.now()),
        time: DateFormat('kk:mm:ss').format(DateTime.now()));
    FirebaseFirestore.instance
        .collection('myNotes')
        .doc(itt.id)
        .update(updatedItem.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange, title: Text(_titleTemp)),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.end,
      
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: TextFormField(
                //controller: titleController,
                onChanged: (value) {
                  setState(() {
                    _titleTemp = value;
                  });
                },
                initialValue: itt.title,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: 'Subject'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: SizedBox(
                child: TextFormField(
                  //controller: textController,
                  initialValue: itt.text,
                  onChanged: (value) {
                    setState(() {
                      _textTemp = value;
                    });
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'Start Typing...'),
                ),
              ),
            ),
         
           Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange),
                      child: Text('Update'),
                      onPressed: () {
                        updateData(_titleTemp, _textTemp);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Container(height: 20,child: Center(child: Text('Record Updated'))),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),duration: Duration(seconds: 1),));

                      },
                    )),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    style: TextButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      deleteData(itt.id);
                      
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Container(height: 20,child: Center(child: Text('Record Deleted'))),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),duration: Duration(seconds: 1),));
                      
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'))
              ]),
            
          ],
        ),
      ),
    );
  }
}

