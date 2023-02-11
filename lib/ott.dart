import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class ott extends StatefulWidget {
  const ott({Key? key}) : super(key: key);

  @override
  State<ott> createState() => _ottState();
}

class _ottState extends State<ott> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTT"),
      ),
      body: Column(
        children: [
          Column(
            children: Global.ott
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('web');
                        setState(() {
                          Global.val = '${e['url']}';
                        });
                        // InAppWebView(
                        //   initialUrlRequest: URLRequest(
                        //     url: Uri.parse("${e['url']}"),
                        //   ),
                        // );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.network(
                              '${e['imeg']}',
                              height: 70,
                              width: 70,
                            ),
                            title: Text(
                              '${e['name']}',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            //subtitle: Text('${e['']}'),
                          ),
                          Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
