import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:serie_a_scores/screens/home.dart';
import 'package:serie_a_scores/screens/settings.dart';
import 'models/match.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

/*
Future<void> main() async {
  await dotenv.load();

  runApp(MaterialApp(
    home: Settings(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Match>? matches;

  Future fetchData() async {
    http.Response response;

    response = await http.get(
        Uri.parse('http://api.football-data.org/v2/competitions/SA/matches?matchday=36'),
        headers: {
          'X-Auth-Token': dotenv.env['API_KEY'] ?? ''
        });
    if (response.statusCode == 200) {
      setState(() {
        var matchesJson = jsonDecode(response.body)['matches'] as List;
        matches = matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serie A scores'),
      ),
      body: (matches == null) ? Container() : Text(matches![0].toString()),
    );
  }
}
*/