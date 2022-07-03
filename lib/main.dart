import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('fr_FR', null);
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

  _ajoutInformation() {
    setState(() {
      informations.insert(0, _card());
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView(
            children: informations,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              _ajoutInformation(), // devrait ouvrir une popin pour saisir texte
          tooltip: 'Ajouter information',
          child: const Icon(Icons.add),
        ),
      );

  Widget _card() {
    final now = DateTime.now();
    return Card(
      child: Column(
        children: [
          Text(
            'Le créneau du dimanche 02 juillet 2022 n\'est pas ouvert.',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            DateFormat.yMMMMEEEEd('fr_FR').format(now),
          ),
        ],
      ),
    );
  }

  ouvreDialogue() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Saisir la nouvelle information :"),
            content: const TextField(
              autofocus: true,
              decoration:
                  InputDecoration(hintText: "Entrer la nouvelle information"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Soumettre"),
              )
            ],
          ));
}