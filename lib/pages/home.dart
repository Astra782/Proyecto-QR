//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_proyect/pages/qr_screen.dart';
//import 'package:qr_proyect/firebase_options.dart';
import 'package:sign_in_button/sign_in_button.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final  FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  User? _user;
  
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) { 
      setState(() {
        _user=event;
      });
    });
    _autostart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesion")
      ),
      body: _user != null ? __userInfo(): _googleSignInButtom(),
    );
  }

  Widget _googleSignInButtom(){
    return Center(child: SizedBox(
      height: 50,
      child: SignInButton(Buttons.google, text:"Iniciar Sesion", onPressed: _handleGoogleSignIn
      ),
    ),);
  }
 // widget _signoutButton(){
   // return Center(child:,)
  //}
  Widget __userInfo(){
    return const SizedBox();
  }

  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider GoogleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(GoogleAuthProvider);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => const QrScreen()));
    }catch(error){
      print(error);
    }
  }
  void _autostart(){
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QrScreen()));
      }
    });
  }
}

