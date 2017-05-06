import 'package:flutter/material.dart';

Drawer buildDrawer(BuildContext context, String currentPage) {
  void goAgenda(){
    if (currentPage == "agenda"){
      Navigator.pop(context);
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
  }

  void goCreator(){
    if (currentPage == "browse"){
      Navigator.pop(context);
    } else {
      Navigator.popAndPushNamed(context, '/browse');
    }
  }

  return new Drawer(
    child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).primaryColor,
          ),
          child: new Center(
            child: new Text('TO-DO')
          ),
        ),
        new ListTile(
          leading: new Icon(Icons.calendar_today),
          selected: (currentPage == 'agenda'),
          title: new Text('Agenda'),
          onTap: goAgenda,
        ),
        new ListTile(
          leading: new Icon(Icons.widgets), // TODO: Verify this icon
          selected: (currentPage == "browse"),
          title: new Text("Data Browser"),
          onTap: goCreator
        )
      ],
    ),
  );
}