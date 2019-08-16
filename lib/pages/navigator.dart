import 'package:flutter/material.dart';
class NavigatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Home'),
              onPressed: () {
                Navigator.of(context).pushNamed("/index");
              },
            ),
            FlatButton(
              child: Text('About'),
              onPressed: () {
                Navigator.of(context).pushNamed("/category");
              },
            ),
            FlatButton(
              child: Text('eat'),
              onPressed: () {
                Navigator.of(context).pushNamed("/eat");
              },
            ),
            FlatButton(
              child: Text('me'),
              onPressed: () {
                Navigator.of(context).pushNamed("/cart");
              },
            ),
            FlatButton(
              child: Text('me'),
              onPressed: () {
                Navigator.of(context).pushNamed("/me");
              },
            )
          ],
        ),
      ),
    );
  }
}