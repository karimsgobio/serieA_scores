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
        Uri.parse('http://api.football-data.org/v2/competitions/SA/matches?matchday=35'),
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
    return (matches == null) ? Container() :
      RefreshIndicator(
        onRefresh: () => fetchData(),
        child: Column(
          children: [
            //Text('Matchday: ${matches![0].matchday.toString()}', textAlign: TextAlign.center,),
            Expanded(
              child: ListView.builder(
                itemCount: matches!.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 110,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.network('https://crests.football-data.org/' + matches![index].homeTeam.id.toString() + '.svg',width: 30,),
                                Text(matches![index].homeTeam.name, textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(matches![index].score.fullTime.homeTeam.toString() + " : " + matches![index].score.fullTime.awayTeam.toString(), textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.network('https://crests.football-data.org/' + matches![index].awayTeam.id.toString() + '.svg',width: 30,),
                                Text(matches![index].awayTeam.name, textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  );
                },
              )
            )
          ]
        )
      );
  }
}