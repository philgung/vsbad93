import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjoutMessage extends StatelessWidget {
  AjoutMessage({
    Key? key,
  }) : super(key: key);

  final informationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Saisir un nouveau message"),
      content: TextFormField(
        autofocus: true,
        controller: informationController,
        decoration: InputDecoration(hintText: "Entrer un nouveau message"),
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
            FirebaseFirestore.instance.collection("Messages").add({
              'contenu': informationController.text,
              'date': Timestamp.fromDate(DateTime.now())
            });
            informationController.clear();
            Navigator.pop(context);
          },
          child: const Text("Soumettre"),
        )
      ],
    );
  }
}
