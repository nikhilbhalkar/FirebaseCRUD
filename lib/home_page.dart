




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter_firebase/update_page.dart';


import 'package:flutter/material.dart';

import 'add_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final Stream<QuerySnapshot> studentstream = FirebaseFirestore.instance.collection('students').snapshots();
   
   //for deleting
   CollectionReference student = FirebaseFirestore.instance.collection('students');
   Future<void>  deleteUser(id){
     return student.doc(id).delete();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Text('Home page',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
           ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddData()),
            );
           }, child: Text('Add')),
         ],
        ),
        backgroundColor: Colors.blue,
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentstream,
        builder: (context,  snapshot){
             if(snapshot.hasError){
              print('Error nikhil');
             }
             if(snapshot.connectionState == ConnectionState.waiting)
             {
              return Center(child: CircularProgressIndicator(),);
             }
            
            final List storageDoc = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String , dynamic>;
              storageDoc.add(a);
              a['id'] = document.id;
            },).toList();

             return   Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storageDoc.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storageDoc[i]['name'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storageDoc[i]['email'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: ()  {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  UpdateData()),
            );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  deleteUser(storageDoc[i]['id']);
                                  },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        })
      
      
    
        
        );
  }
}