import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'global.dart';

class webpage extends StatefulWidget {
  const webpage({Key? key}) : super(key: key);

  @override
  State<webpage> createState() => _webpageState();
}

class _webpageState extends State<webpage> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  List allBookmarks = [];
  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.red),
        onRefresh: () async {
          if (Platform.isAndroid) {
            await inAppWebViewController!.reload();
          } else if (Platform.isIOS) {
            await inAppWebViewController!.loadUrl(
                urlRequest: URLRequest(
              url: await inAppWebViewController!.getUrl(),
            ));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browser'),
        //  centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Uri? uri = await inAppWebViewController!.getUrl();

                allBookmarks.add(uri!.toString());
              },
              icon: Icon(Icons.bookmark)),
          IconButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                await inAppWebViewController!.goBack();
              }
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          IconButton(
              onPressed: () async {
                await inAppWebViewController!.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse("${Global.val}")));
              },
              icon: Icon(Icons.home)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoForward()) {
                  await inAppWebViewController!.goForward();
                }
              },
              icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("${Global.val}"),
        ),
        onWebViewCreated: (val) {
          inAppWebViewController = val;
        },
        pullToRefreshController: pullToRefreshController,
        onLoadStop: (controller, uri) async {
          await pullToRefreshController.endRefreshing();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bookmark_border_rounded),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Center(
                      child: Text("all Booknarks link"),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: allBookmarks
                          .map(
                            (e) => GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();

                                  await inAppWebViewController!
                                      .loadUrl(urlRequest: URLRequest(url: e));
                                },
                                child: Text(
                                  e,
                                  style: TextStyle(color: Colors.blue),
                                )),
                          )
                          .toList(),
                    ),
                  ));
        },
      ),
    );
  }
}
