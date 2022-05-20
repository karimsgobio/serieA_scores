import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final Uri _authorUrl = Uri.parse('https://github.com/karimsgobio');
  final Uri _sourceCodeUrl = Uri.parse('https://github.com/karimsgobio/serieA_scores');
  final Uri _creditsUrl = Uri.parse('https://www.football-data.org/');

  void _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('About'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Author'),
              value: Text(_authorUrl.toString()),
              onPressed: (context) => _launchUrl(_authorUrl),
            ),
            SettingsTile(
              leading: const Icon(Icons.code),
              title: const Text('Source code'),
              value: Text(_sourceCodeUrl.toString()),
              onPressed: (context) =>  _launchUrl(_sourceCodeUrl),
            ),
            SettingsTile(
              leading: const Icon(Icons.attribution),
              title: const Text('Credits'),
              value: const Text('Football data provided by the Football-Data.org API'),
              onPressed: (context) =>  _launchUrl(_creditsUrl),
            ),
          ],
        )
      ],
    );
  }
}
