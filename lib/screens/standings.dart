import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serie_a_scores/models/team.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Standings extends StatefulWidget {
  const Standings({ Key? key }) : super(key: key);

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  List<Team>? teams;

  Future fetchData() async {
    http.Response responseTeams;

    responseTeams = await http.get(
        Uri.parse('http://api.football-data.org/v2/competitions/SA/standings'),
        headers: {
          'X-Auth-Token': dotenv.env['API_KEY'] ?? ''
        });
    if (responseTeams.statusCode == 200) {
      setState(() {
        var teamsJson = jsonDecode(responseTeams.body)['standings'][0]['table'] as List;
        teams = teamsJson.map((teamJson) => Team.fromJsonTeams(teamJson)).toList();
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
    return (teams == null) ? Container() : 
    RefreshIndicator(
      onRefresh: () => fetchData(),
      child:SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: DataTable(
          columnSpacing: 25,
          columns: const [
            DataColumn(
              label: Expanded(child: Text('Position',textAlign: TextAlign.center,)),
            ),
            DataColumn(
              label: Expanded(child: Text('Name',textAlign: TextAlign.center,)),
            ),
            DataColumn(
              label: Expanded(child: Text('Points',textAlign: TextAlign.center,)),
            ),
          ],
          rows: teams!.map((team) =>
            DataRow(
              cells: [
                DataCell(Center(child: Text(team.position.toString()))),
                DataCell(Row(children: [
                  SvgPicture.network('https://crests.football-data.org/' + team.id.toString() + '.svg',width: 30,),
                  Flexible(child: Text(team.name)),
                  ])
                ),
                DataCell(Center(child: Text(team.points.toString()))),
              ]
            )
          ).toList()
        )
      )
    );
  }
}