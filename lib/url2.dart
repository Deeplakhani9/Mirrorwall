import 'package:flutter/material.dart';
import 'package:mirrorwall/global.dart';

class education extends StatefulWidget {
  const education({Key? key}) : super(key: key);

  @override
  State<education> createState() => _educationState();
}

class _educationState extends State<education> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Education"),
        ),
        body: Column(
          children: [
            Column(
              children: Global.edu
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
        ));
  }
}
