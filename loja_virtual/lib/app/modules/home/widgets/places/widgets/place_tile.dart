import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.get('image'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get('title'),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  snapshot.get('address'),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  launch("https://www.google.com/maps/search/?api=1&query=${snapshot.get('lat')},${snapshot.get('long')}");
                },
                child: Text('Ver no mapa'),
              ),
              TextButton(
                onPressed: () {
                  launch('tel:${snapshot.get('phone')}');
                },
                child: Text('Ligar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
