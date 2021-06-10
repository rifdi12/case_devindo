import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalSearch extends StatefulWidget {
  const LocalSearch({Key key}) : super(key: key);

  @override
  _LocalSearchState createState() => _LocalSearchState();
}

class _LocalSearchState extends State<LocalSearch> {
  List data = [];

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/file/category.json');
    setState(() => data = json.decode(jsonText));
  }

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Search here...'),
            onChanged: (value) {
              setState(() {});
            },
            controller: editingController,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                if (editingController.text.isEmpty) {
                  return ListTile(
                    title: Text('${data[index]['title']}'),
                  );
                } else if (data[index]['title']
                    .toLowerCase()
                    .contains(editingController.text)) {
                  return ListTile(
                    title: Text('${data[index]['title']}'),
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}
