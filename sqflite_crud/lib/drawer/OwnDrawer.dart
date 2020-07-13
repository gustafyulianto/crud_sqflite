import 'package:flutter/material.dart';
import 'package:sqflite_crud/drawer/MainDrawer.dart';
import 'package:sqflite_crud/screen/data.dart';
import 'package:sqflite_crud/screen/register_view.dart';
import 'package:sqflite_crud/screen/login.dart';

class OwnDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Gustaf Yulianto"),
                accountEmail: Text(
                  "gustaf.julianto@gmail.com",
                  style: TextStyle(fontFamily: 'DancingScript'),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    "G",
                    style:
                        TextStyle(fontSize: 40.0, fontFamily: 'DancingScript'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.menu),
                  title: Text(
                    "Home",
                    style: TextStyle(fontSize: 20, fontFamily: 'DancingScript'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main()),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text(
                    "Student Data Form",
                    style: TextStyle(fontSize: 20, fontFamily: 'DancingScript'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListMahasiswa()),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text(
                    "Register User List",
                    style: TextStyle(fontSize: 20, fontFamily: 'DancingScript'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 20, fontFamily: 'DancingScript'),
                  ),
                  onTap: () {
                    AlertDialog delete = AlertDialog(
                      title: Text('Information'),
                      content: Container(
                        height: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text('Are You Sure to Logout'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                      ],
                    );
                    showDialog(context: context, child: delete);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
