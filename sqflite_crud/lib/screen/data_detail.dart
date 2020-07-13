import 'package:flutter/material.dart';
import 'package:sqflite_crud/model/mahasiswa.dart';
import 'package:sqflite_crud/db/db_sqflite.dart';
import 'package:sqflite_crud/screen/data.dart';

class AddData extends StatefulWidget {
  final Mahasiswa mahasiswa;
  AddData({this.mahasiswa});
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  List<Mahasiswa> listMahasiswa = List();
  db_sqflite db = db_sqflite();

  String _Gender = "";

  List<String> agama = ["Islam", "Kristen", "Hindu", "Budha", "Others"];
  String _agama = "Islam";

  void _PilihKelamin(String value) {
    setState(() {
      _Gender = value;
    });
  }

  void _pilihAgama(String value) {
    setState(() {
      _agama = value;
    });
  }

  TextEditingController Name;
  TextEditingController BirthPlace;
  TextEditingController RegEmail;
  TextEditingController HpNumber;
  @override
  void initState() {
    Name = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.Name);
    BirthPlace = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.BirthPlace);
    RegEmail = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.RegEmail);
    HpNumber = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.HpNumber);
    _Gender = (widget.mahasiswa == null ? '' : widget.mahasiswa.Gender);
    _agama = (widget.mahasiswa == null ? 'Islam' : widget.mahasiswa.Religion);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.account_box),
        title: Center(child: Text("Form Student")),
        backgroundColor: Colors.blue,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: Name,
                  decoration: new InputDecoration(
                      hintText: "Name",
                      labelText: "Full Name",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: BirthPlace,
                  decoration: new InputDecoration(
                      hintText: "Place of Birth",
                      labelText: "Place of Birth",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                          width: 1,
                          color: Colors.black45,
                          style: BorderStyle.solid)),
                  child: Row(
                    children: <Widget>[
                      new Radio(
                        value: "Laki-laki",
                        groupValue: _Gender,
                        onChanged: (String value) {
                          _PilihKelamin(value);
                        },
                        activeColor: Colors.red,
                      ),
                      new Text(
                        "Laki-Laki",
                        style: TextStyle(fontSize: 18),
                      ),
                      new Radio(
                        value: "Perempuan",
                        groupValue: _Gender,
                        onChanged: (String value) {
                          _PilihKelamin(value);
                        },
                        activeColor: Colors.red,
                      ),
                      new Text(
                        "Perempuan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                          width: 1,
                          color: Colors.black45,
                          style: BorderStyle.solid)),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "  Pilih Agama",
                        style: TextStyle(fontSize: 18.0, color: Colors.black45),
                      ),
                      SizedBox(width: 50),
                      new DropdownButton(
                        onChanged: (String value) {
                          _pilihAgama(value);
                        },
                        value: _agama,
                        items: agama.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: RegEmail,
                  decoration: new InputDecoration(
                      hintText: "Email",
                      labelText: "Registration Email",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: HpNumber,
                  decoration: new InputDecoration(
                      hintText: "HP Number",
                      labelText: "HP Number",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 50),
                new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                          child: (widget.mahasiswa == null)
                              ? new Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "Update",
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            sendUpsert();
                            //send();
                          }),
                      SizedBox(width: 10),
                      new RaisedButton(
                          child: new Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            Cancel();
                            //send();
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendUpsert() async {
    if (widget.mahasiswa != null) {
      await db.updateMahasiswa(Mahasiswa.fromMap({
        'id': widget.mahasiswa.id,
        'Name': Name.text,
        'Birthplace': BirthPlace.text,
        'Gender': _Gender,
        'Religion': _agama,
        'RegEmail': RegEmail.text,
        'HpNumber': HpNumber.text,
      }));
      Navigator.pop(context, 'Update');
    } else {
      await db.saveMahasiswa(Mahasiswa(
        Name: Name.text,
        BirthPlace: BirthPlace.text,
        Gender: _Gender,
        Religion: _agama,
        RegEmail: RegEmail.text,
        HpNumber: HpNumber.text,
      ));
      Navigator.pop(context, 'Add');
    }
  }

  Future<void> Cancel() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListMahasiswa()),
    );
  }
}
