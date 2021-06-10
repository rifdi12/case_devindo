import 'package:case_devindo/bloc/infintelist_bloc.dart';
import 'package:case_devindo/detail_infinte_list.dart';
import 'package:case_devindo/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfinteList extends StatefulWidget {
  const InfinteList({Key key}) : super(key: key);

  @override
  _InfinteListState createState() => _InfinteListState();
}

class _InfinteListState extends State<InfinteList> {
  @override
  void initState() {
    BlocProvider.of<InfintelistBloc>(context).add(InfinteListEventInit());

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 10.0;
  bool loading = true;

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      setState(() {
        loading = true;
      });
      BlocProvider.of<InfintelistBloc>(context).add(
        InfinteListLazyLoad(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfintelistBloc, InfintelistState>(
        listener: (context, state) {
      if (state is InfinteListLoaded) {
        setState(() {
          loading = false;
        });
      }
    }, builder: (context, state) {
      if (state is InfintelistInitial) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is InfinteListLoaded) {
        List<User> user = state.user;
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<InfintelistBloc>(context)
                .add(InfinteListEventInit());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Scrollbar(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: user.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailInfiniteList(
                                  user: user[index],
                                ),
                              ),
                            );
                          },
                          title: Text('${user[index].title}'),
                        );
                      },
                    ),
                    if (loading == true) BottomLoader()
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          // width: 33,
          // height: 33,
          child: CircularProgressIndicator(
              // strokeWidth: 1.5,
              ),
        ),
      ),
    );
  }
}
