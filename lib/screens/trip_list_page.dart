import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TripListPage extends StatefulWidget{
  const TripListPage({Key? key}):super(key: key);

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage>{
  List _items = [];

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/destinosdata.json');
    final data = await json.decode(response);
    setState((){
      _items = data['destinos'];
      print("items loaded from trip_list_page");
    });
  }

  @override
  void initState() {
    readJson();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: _items.isNotEmpty?Expanded(
          child: ListView.builder(
          itemCount: _items.length,
            itemBuilder: (context, index){
            return Card(
              key: ValueKey(_items[index]['id']),
              margin: const EdgeInsets.all(10),
              color: Colors.green,
              child: ListTile(
                //leading: Text(_items[index]['id']),
                title: Text(_items[index]['nome']),
                subtitle: Text(_items[index]['descricao']),
              ),
            );
            },
          )
        ) :Text(' Data: Load Items'),
    );
  }
}