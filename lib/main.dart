import 'package:flutter/material.dart';
import 'package:mirrorwall/ott.dart';
import 'package:mirrorwall/url2.dart';
import 'package:mirrorwall/web.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => deep(),
        'web': (context) => webpage(),
        '1': (context) => ott(),
        '2': (context) => education(),
      },
    ),
  );
}

class deep extends StatefulWidget {
  const deep({Key? key}) : super(key: key);

  @override
  State<deep> createState() => _deepState();
}

class _deepState extends State<deep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushNamed('1');
                  });
                },
                child: Text("Go to OTT platform")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushNamed('2');
                  });
                },
                child: Text("Go to education page")),
          ],
        ),
      ),
    );
  }
}
