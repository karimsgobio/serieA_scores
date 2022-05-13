import 'package:flutter/material.dart';

class Standings extends StatefulWidget {
  const Standings({ Key? key }) : super(key: key);

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Standings\' page'),
    );
  }
}