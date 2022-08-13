import 'package:data_table_2/data_table_2.dart';
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
        child: DataTable2(
          smRatio: 0.35,
          columns: const [
            DataColumn2(
              label: Center(child: Text('#',textAlign: TextAlign.center,)),
              size: ColumnSize.S,
              numeric: true,
            ),
            DataColumn2(
              label: Center(child: Text('Team',textAlign: TextAlign.center,)),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Center(child: Text('P',textAlign: TextAlign.center,)),
              size: ColumnSize.S,
              numeric: true,
            ),
          ],
          rows: teams!.map((team) =>
            DataRow(
              cells: [
                DataCell(Center(child: Text(team.position.toString()))),
                DataCell(
                  Row(
                    children: [
                      (team.crestUrl.contains('svg')) ?
                        SvgPicture.network(team.crestUrl,width: 30,)
                        :
                        Image.network(team.crestUrl,width: 30,),
                      const Text(" "),
                      Flexible(child: Text(team.name)),
                    ]
                  ),
                ),
                DataCell(Center(child: Text(team.points.toString()))),
              ]
            )
          ).toList()
        )
      );
  }
}