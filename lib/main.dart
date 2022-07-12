import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Messages/AfficheMessage.dart';
import 'Messages/AjoutMessage.dart';

Future<void> main() async {
  initializeDateFormatting('fr_FR', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VS Bad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'VS Bad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> informations = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () => {},
                iconSize: 75.0,
                icon: Image.asset('assets/logo_vsbad93.png'))
          ],
        ),
        body: Center(child: Messages()),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Ajouter information',
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AjoutMessage();
                });
          },
          child: Icon(Icons.add),
        ),
      );
}

class Messages extends StatelessWidget {
  Messages({
    Key? key,
  }) : super(key: key);

  final Stream<QuerySnapshot> messagesStream =
      FirebaseFirestore.instance.collection('Messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("En cours de chargement ...");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> message =
                  document.data()! as Map<String, dynamic>;
              return AfficheMessage(message: message);
            }).toList(),
            reverse: true,
            shrinkWrap: true,
          );
        });
  }
}
