import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_auth/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey <FormState>();
  final GlobalKey <ScaffoldState> _scaffoldKey = GlobalKey <ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        withEmailPassword(),
      ],
      ),
    );
  }
  Widget withEmailPassword(){
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Sign In with Email and Password',
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                alignment: Alignment.center,
                child: OutlineButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      _signInWithEmailPassword();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _signInWithEmailPassword() async{
    try {
      final User user = (await _auth.signInWithEmailAndPassword(email: _emailController.text,password: _passwordController.text)
           ).user;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return MainPage(user: user,
        );
      }));
    }
    catch (e) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Failed to sign in with Email and Password')));
      print(e);
    }

  }

}
