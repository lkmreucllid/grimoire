import 'package:flutter/material.dart';

class OpenFeed extends StatefulWidget {
  final feedId;

  const OpenFeed({Key key, this.feedId}) : super(key: key);

  @override
  _OpenFeedState createState() => _OpenFeedState();
}

class _OpenFeedState extends State<OpenFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.feedId),
      ),
    );
  }
}
