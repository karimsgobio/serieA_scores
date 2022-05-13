import 'package:flutter/material.dart';

class Matches extends StatefulWidget {
  const Matches({ Key? key }) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Matches\' page'),
    );
  }
}