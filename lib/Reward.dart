import 'dart:async';
import 'package:flutter/material.dart';
import 'ExpenseListModel.dart';

 /*class Reward {
  final String code;

  Reward(this.code);
}

 manageReward () async {
  var dt = DateTime.now();
  var day = dt.add(new Duration(days: 2));
  var expenseId=0; */

 /* while ( expenseId!= 0) {
    if ( dt == day ) {
      if ( expenseId == day ) {
        return Future.delayed(Duration(seconds: 4), () => getRewards());}
      else if ( expenseId != day ) {
        Future.delayed(Duration(seconds:4), () => 'Please input the expense');
        return null;
      }
      else{
        return null;
      }
    }
  }
} */

// ignore: camel_case_types
class getRewards extends StatefulWidget {
  getRewards({Key key,this.id, this.expenses}) : super(key: key);
  final ExpenseListModel expenses;
  final int id;

  @override
  _getRewardsState createState() => _getRewardsState(id: id, expenses: expenses);
}

class _getRewardsState extends State<getRewards> {
  _getRewardsState({Key key, this.id, this.expenses});
  final int id;
  final ExpenseListModel expenses;
  Stream<int> _reward = (() async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield 1;
    await Future<void>.delayed(Duration(seconds: 1));
  })();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    title: const Text('Rewards'),
    ),
    body: new Container(
      child: StreamBuilder<int>(
        stream: _reward,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          List<Widget> children;
          if (snapshot.hasError){
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              // ignore: missing_return
              )
            ];
          } else {
            if ( id!=0 && expenses !=0){
              switch (snapshot.connectionState){
                case ConnectionState.none :
                  children = <Widget> [
                    Icon(Icons.lock_outline,
                      color: Colors.black,),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text('Please fulfill the expenses for the month'),
                    )
                  ];

                  break;
                case ConnectionState.waiting:
                  children = <Widget> [
                    SizedBox(
                      child: const CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ];
                  break;
                case ConnectionState.active:
                  if ( id != 0){
                    children = <Widget> [
                      Icon(Icons.lock_outline,
                        color: Colors.black45,),

                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text('Please fulfill the expenses for the month'),
                      )
                    ];
                  }
                  break;
                case ConnectionState.done :
                  if ( expenses == id ) {
                    children = <Widget> [
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Icons.lock_open),
                        onPressed: () {},),

                    ];
                  }
                  break;
              }
            };
            }
       //   }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
        },
        ),
      ),
      );
  }
}

