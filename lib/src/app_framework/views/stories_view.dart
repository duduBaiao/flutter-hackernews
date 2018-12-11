import 'package:flutter/material.dart';

class StoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: _getFuture(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Container(
              height: 80,
              child: snapshot.hasData ? Text('Im visible $index') : Text('You cant see me $index'),
            );
          },
        );
      },
      itemCount: 1000,
    );
  }

  _getFuture() {
    return Future.delayed(Duration(seconds: 2), () => '');
  }
}
