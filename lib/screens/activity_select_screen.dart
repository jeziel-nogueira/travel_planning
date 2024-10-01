import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ActivityDetails extends StatefulWidget {
  final Map<String, dynamic> place;

  const ActivityDetails({super.key, required this.place});

  @override
  State<ActivityDetails> createState() => _ActivityDetails();
}

class _ActivityDetails extends State<ActivityDetails> {
  Map<String, dynamic>? _selectedActivity;
  int? _selectedIndex;
  double? _selectedCost;

  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    if(widget.place is String){
      print('is a String: ${widget.place['cost']}');
    }
    if(widget.place is int){
      print('is a int value: ${widget.place['cost']}');
    }
    super.initState();
  }

  void selectActivity(Map<String, dynamic> activity, int index) {
    setState(() {
      _selectedActivity = activity; // Define a atividade selecionada
      _selectedIndex = index; // Atualiza o índice do checkbox selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(widget.place['images']),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      spreadRadius: 4)
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  widget.place['description'],
                  style: GoogleFonts.getFont('Roboto Condensed',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black26),
                ),
                newActivity(), // Exibe as atividades
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Custo',
                        style: GoogleFonts.getFont('Roboto Condensed',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black38),
                      ),
                    ),
                    _selectedCost != null
                        ? Text(
                            currencyFormatter.format(_selectedCost),
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                          )
                        : Text("0"),
                  ],
                ),
              ),
              Container(
                child: _selectedActivity != null
                    ? GestureDetector(
                        onTap: () {
                          print(_selectedActivity);
                          Navigator.pop(context, _selectedActivity);
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.8,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Selecione uma Atividade',
                              style: GoogleFonts.getFont("Roboto Condensed",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Text('Selecione uma Atividade...'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newActivity() {
    return Container(
      height: 600,
      child: ListView.builder(
        itemCount: widget.place['activities'].length,
        itemBuilder: (context, index) {
          var activity = widget.place['activities'][index];
          bool _isSelected = _selectedIndex ==
              index; // Apenas o índice selecionado fica marcado

          return GestureDetector(
            onTap: () {
              print("Selected ${activity['name']}");
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Read More");
                    },
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.zero,
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.zero,
                                topLeft: Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(activity['images']),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.zero,
                                topRight: Radius.circular(10),
                                topLeft: Radius.zero),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(activity['name']),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  activity['description'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        //selectActivity(activity, index); // Seleciona a atividade
                      },
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        value: _isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedCost = activity['cost'];
                            _selectedActivity = activity;
                            _selectedIndex =
                                index; // Atualiza o índice selecionado
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
