import 'package:flutter/material.dart';
import 'package:sqflite_crud/model/mahasiswa.dart';
import 'package:sqflite_crud/db/db_sqflite.dart';
import 'package:sqflite_crud/screen/data_detail.dart';
import 'package:sqflite_crud/drawer/MainDrawer.dart';

import 'view_detail.dart';

class ListMahasiswa extends StatefulWidget {
  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List<Mahasiswa> listMahasiswa = List();
  db_sqflite db = db_sqflite();

  @override
  void initState() {
    _getAllMahasiswa();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.account_box),
          centerTitle: true,
          title: Text("STUDENT FORM"),
          backgroundColor: Colors.blue,
        ),
        body: new ListView.builder(
            itemCount: listMahasiswa.length,
            itemBuilder: (context, i) {
              Mahasiswa mahasiswa = listMahasiswa[i];
              return ListTile(
                onTap: () {
                  //edit
                  _openFormEdit(mahasiswa);
                },
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "${mahasiswa.Name} ${mahasiswa.Religion}",
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
                subtitle: Text(mahasiswa.RegEmail),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    AlertDialog delete = AlertDialog(
                      title: Text('Information'),
                      content: Container(
                        height: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                                'Are You Sure to Delete this data ${mahasiswa.Name}'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            _deleteMahasiswa(mahasiswa, i);
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');

                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListMahasiswa(),
                                ));*/
                          },
                        ),
                      ],
                    );
                    showDialog(context: context, child: delete);
                  },
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => view_detail(mahasiswa)));
                  },
                  icon: Icon(Icons.visibility),
                ),
              );
            }),
        /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          _openFormCreate();
        },
      ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Main()),
                  );
                },
                child: Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  _openFormCreate();
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ));
  }

  Future<void> _getAllMahasiswa() async {
    var list = await db.getAllMahasiswa();
    setState(() {
      listMahasiswa.clear();
      list.forEach((mahasiswa) {
        listMahasiswa.add(Mahasiswa.fromMap(mahasiswa));
      });
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddData(),
        ));

    if (result == 'Add') {
      await _getAllMahasiswa();
    }
  }

  Future<void> _openFormEdit(Mahasiswa mahasiswa) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddData(mahasiswa: mahasiswa),
        ));

    if (result == 'Update') {
      await _getAllMahasiswa();
    }
  }

  Future<void> _deleteMahasiswa(Mahasiswa mahasiswa, int Position) async {
    await db.deleteMahasiswa(mahasiswa.id);
    setState(() {
      listMahasiswa.removeAt(Position);
    });
  }
}
