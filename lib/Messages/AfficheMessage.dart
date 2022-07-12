import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AfficheMessage extends StatelessWidget {
  const AfficheMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              title: Text(message['contenu'],
                  style: Theme.of(context).textTheme.headline6),
              subtitle: Text(DateFormat.yMMMMEEEEd('fr_FR').format(
                  (DateTime.fromMicrosecondsSinceEpoch(
                      (message['date'] as Timestamp)
                          .microsecondsSinceEpoch))))),
        ],
      ),
    );
  }
}
