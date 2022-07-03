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
  final informationController = TextEditingController();

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
        body: Center(
          child: ListView(
            children: informations,
            reverse: true,
            shrinkWrap: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Ajouter information',
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Saisir la nouvelle information"),
                    content: TextFormField(
                      autofocus: true,
                      controller: informationController,
                      decoration: InputDecoration(
                          hintText: "Entrer la nouvelle information"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler"),
                      ),
                      TextButton(
                        onPressed: () {
                          ajoutInformation(informationController.text);
                          informationController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Soumettre"),
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
      );

  @override
  void dispose() {
    informationController.dispose();
    super.dispose();
  }

  ajoutInformation(String information) {
    setState(() {
      informations.add(Card(
        child: Column(
          children: [
            Text(
              information,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              DateFormat.yMMMMEEEEd('fr_FR').format(DateTime.now()),
            ),
          ],
        ),
      ));
    });
  }
}
