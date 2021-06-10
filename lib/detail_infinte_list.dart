import 'package:case_devindo/bloc/infintelist_bloc.dart';
import 'package:case_devindo/model/user.dart';
import 'package:flutter/material.dart';

class DetailInfiniteList extends StatefulWidget {
  final User user;
  const DetailInfiniteList({Key key, this.user}) : super(key: key);

  @override
  _DetailInfiniteListState createState() => _DetailInfiniteListState();
}

class _DetailInfiniteListState extends State<DetailInfiniteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              text('ID', '${widget.user.id}'),
              SizedBox(
                height: 10,
              ),
              text('User ID', '${widget.user.userId}'),
              SizedBox(
                height: 10,
              ),
              text('Title', '${widget.user.title}'),
              SizedBox(
                height: 10,
              ),
              text('body', '${widget.user.body}'),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget text(String title, String body) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(title)),
        SizedBox(
          width: 10,
        ),
        Flexible(flex: 3, child: Text(body)),
      ],
    );
  }
}
