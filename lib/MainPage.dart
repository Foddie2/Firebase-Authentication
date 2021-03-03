import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_auth/FirebaseAuthDemo.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key key, this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey <ScaffoldState> _scaffoldKey = GlobalKey <ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(widget.user.displayName,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: OutlineButton(
                onPressed: () {
                  _signOut().whenComplete(() => {
                    Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_){
                      return FirebaseAuthDemo();
                    }))
                  });
                },
                child: Text('LogOut'),

              )
            ),
          ],
        ),
      ),
    );
  }
  Future _signOut() async {
    await _auth.signOut();
  }
}
