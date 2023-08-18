import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'crud_provider_based.dart/userinfo_provider.dart';
import 'crud_provider_based.dart/userinterface.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyAppnew());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          print('error is coming nik');
        }
        if(snapshot.connectionState == ConnectionState.done){
          return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
        }
        return Center(child: CircularProgressIndicator(),);
      });
    
    
    
    
  }
}


class MyAppnew extends StatelessWidget {
   MyAppnew({super.key});
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child:  FutureBuilder(
          future: _intialization,
          builder: (context,snapshot){
            if(snapshot.hasError){
              print('error is coming nik');
            }
            if(snapshot.connectionState == ConnectionState.done){
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home:  UserScreen(),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          })

    );
  }
}
