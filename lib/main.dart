import 'package:flutter/material.dart';
import 'package:preferme/data/storage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  void initState() {
    Storage().getData('darkTheme').then((value) {
      if (value != null) {
        setState(() {
          isDark = value;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.green
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PreferMe!'),
          actions: <Widget>[
            Switch(
              value: isDark,
              onChanged: (value) async {
                await Storage().saveThemePreference(value);
                setState(() {
                  isDark = value;
                });
              },
            )
          ],
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.call,
            ),
            onPressed: () async {
              await UrlLauncher.launch('tel://+123');
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.email),
            onPressed: () async {
              await UrlLauncher.launch('mailto:igadget28@gmail.com');
            },
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 250.0,
            child: DetailCard(),
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.account_box,
              size: 26.0,
            ),
            title: Text(
              "InspectorGadget",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text("Mobile Developer"),
          ),
          Divider(
            color: Colors.blue,
            thickness: 2.0,
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              size: 26.0,
            ),
            title: Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            subtitle: Text("igadget28@gmail.com"),
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              size: 26.0,
            ),
            title: Text(
              "Mobile",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            subtitle: Text("+123"),
          ),
        ],
      ),
    );
  }
}
