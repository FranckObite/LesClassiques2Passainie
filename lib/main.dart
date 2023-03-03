import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        //correspond au theme claire
        light:
            ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
        //correspond au theme sombre
        dark: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.orange),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
              title: "Mon App Mode",
              theme: theme,
              darkTheme: darkTheme,
              home: MyHomePage(title: "Mon App Mode"),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkmode = false;
  dynamic savedThemeMode;
  String? iconAdess;

  // faire de sorte que des le telechargement, on puisse detecter quel est le thème actuellement présent

  void initState() {
    super.initState();
    recuperationDuThemeEnQuestion();
  }

  Future recuperationDuThemeEnQuestion() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('theme sombre');
      setState(() {
        darkmode = true;
        iconAdess = "images/dark.png";
      });
    } else {
      print('theme clair');
      setState(() {
        darkmode = false;
        iconAdess = "images/ligth.png";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              child: iconAdess != null ? Image.asset(iconAdess!) : Container(),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text("Changer de thème",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20.0,
            ),
            Text(
                'vous pouvez changer le thème de \n l\'interface de votre app'),
            SizedBox(
              height: 20.0,
            ),
            SwitchListTile(
                title: Text('mode sombre'),
                activeColor: Colors.orange,
                secondary: const Icon(Icons.nightlight_round),
                value: darkmode,
                onChanged: (bool value) {
                  print(value);
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                    iconAdess = "images/dark.png";
                  } else {
                    AdaptiveTheme.of(context).setLight();
                    iconAdess = "images/ligth.png";
                  }
                  setState(() {
                    darkmode = value;
                  });
                })
            /* ElevatedButton(
                onPressed: () {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
                child: Text('Changer de theme')) */
          ],
        ),
      ),
    );
  }
}
