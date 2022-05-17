import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serie_a_scores/models/match.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Matches extends StatefulWidget {
  const Matches({ Key? key }) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<Match>? matches;

  Future fetchData() async {
    http.Response responseMatches;
    
    responseMatches = await http.get(
        Uri.parse('http://api.football-data.org/v2/competitions/SA/matches?matchday=36'),
        headers: {
          'X-Auth-Token': dotenv.env['API_KEY'] ?? ''
        });
    if (responseMatches.statusCode == 200) {
      setState(() {
        var matchesJson = jsonDecode(responseMatches.body)['matches'] as List;
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
    return Center(
      child: (matches == null) ? Container() : Text(matches![0].toString()),
      //child: (matches == null) ? Container() : SvgPicture.network('https://crests.football-data.org/' + matches![0].idHomeTeam.toString() + '.svg'),
    );
  }
}