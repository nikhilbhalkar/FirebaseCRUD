import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_firebase/text_input_field.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
   AddData({super.key});


  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

var name = "";
var email = "";
var password = "";

   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

//adding data
CollectionReference student = FirebaseFirestore.instance.collection('students');
  Future<void> addUser(){
      return student.add({
        'name': name,
        'email': email,
        'password': password
      });
  }

  clearText(){
       _emailController.clear();
       _nameController.clear();
       _passwordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text(
              ' Register',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
           
           
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _nameController,
                lableText: 'Username',
                icon: Icons.person,
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                lableText: 'Email',
                icon: Icons.email,
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                lableText: 'Password',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                onTap: () {

                  setState(() {
                    name = _nameController.text;
                    email = _emailController.text;
                    password = _passwordController.text;
                    addUser();
                    clearText();
                  });
                },
                child: const Center(
                    child: Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
           
          ],
        ),
      ),
    );
  }
}
