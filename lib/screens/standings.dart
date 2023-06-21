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
        Uri.parse('http://api.football-data.org/v4/competitions/SA/standings'),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.top,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 25,
                columns: const [
                  DataColumn(
                    label: Text('#'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('Team'),
                  ),
                  DataColumn(
                    label: Text('Pts'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('W'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('D'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('L'),
                    numeric: true,
                  ),
                ],
                rows: teams!.map((team) =>
                  DataRow(
                    cells: [
                      DataCell(Text(team.position.toString())),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (team.crestUrl.contains('svg')) ?
                              SvgPicture.network(team.crestUrl,width: 30,)
                              :
                              Image.network(team.crestUrl,width: 30,),
                            const Text(" "),
                            Flexible(child: Text(team.name,)),
                          ]
                        ),
                      ),
                      DataCell(Text(team.points.toString())),
                      DataCell(Text(team.won.toString())),
                      DataCell(Text(team.draw.toString())),
                      DataCell(Text(team.lost.toString())),
                    ]
                  )
                ).toList()
              ),
            ),
          ),
        ),
      );
  }
}