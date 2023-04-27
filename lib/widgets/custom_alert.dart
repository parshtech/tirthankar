import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  Color _color = Color.fromARGB(220, 117, 218, 255);
  Widget? _child1;
  Widget? _child2;
  String? _child1text;
  String? _child2text;
  String? _title;
  String? _content;
  String? _yes;
  String? _no;
  Function? _yesOnPressed;
  Function? _noOnPressed;

  BaseAlertDialog(
      {Widget? child1,
      Widget? child2,
      String? child1text,
      String? child2text,
      String? title,
      String? content,
      Function? yesOnPressed,
      Function? noOnPressed,
      String yes = "Yes",
      String no = "No"}) {
    this._child1 = child1;
    this._child2 = child2;
    this._child1text = child1text;
    this._child2text = child2text;
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: new Text(this._title),
      // content: new Text(this._content),
      backgroundColor: Colors.amberAccent[50],
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        ElevatedButton(
          // color: Colors.orangeAccent[300],
          // padding: EdgeInsets.all(30.0),
          style: raiseButtonStyle,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _child1,
                // Icon(
                //   Icons.music_video,
                //   color: Colors.orange[300],
                //   size: 50,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  _child1text!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
            this._yesOnPressed!();
          },
        ),
        ElevatedButton(
          // color: Colors.orangeAccent[300],
          // padding: EdgeInsets.all(30.0),
          style: raiseButtonStyle,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _child2,
                // Icon(
                //   Icons.book,
                //   color: Colors.orange[300],
                //   size: 50,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  _child2text!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
            this._noOnPressed!();
          },
        ),
      ],
    );
  }

  final ButtonStyle raiseButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.orangeAccent[300],
    // minimumSize: Size(88, 44),
    // padding: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(30.0),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(200)),
    // ),
    // backgroundColor: Colors.blue,
  );
}
