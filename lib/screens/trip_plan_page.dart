import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TripPlanPage extends StatefulWidget {
  final Map<String, dynamic> plan;
  final bool isLightTheme;
  final VoidCallback toggleTheme;


  const TripPlanPage({
    super.key,
    required this.plan,
    required this.isLightTheme,
    required this.toggleTheme,
  });

  @override
  State<TripPlanPage> createState() => _TripPlan();
}

class _TripPlan extends State<TripPlanPage> {
  bool? isChecked;
  double? _budget;
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: '\$');

  List<Widget> _activitiesList = [];
  List<bool> _isCheckedList = [];
  List<Widget> _activitiesListContent = [];





  void addNewActivity() {
    _isCheckedList.add(false); // Inicializa o estado do Checkbox como desmarcado
    _activitiesList.add(_activity(_activitiesList.length)); // Passa o índice da atividade
    setState(() {
      _activitiesListContent = _activitiesList;
    });
  }

  void changeActivity(int index, bool state){
    setState(() {
      print(state);
      _isCheckedList[index] = state;
      _activitiesListContent = _activitiesList;
    });
  }

  Widget _activity(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 90,
            margin: const EdgeInsets.symmetric(vertical: 10), // Espaçamento entre as atividades
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.zero, bottomLeft: Radius.circular(15), bottomRight: Radius.zero),
            ),
            child: Center(
              child: Checkbox(
                value: _isCheckedList[index],
                onChanged: (bool? value) {
                  changeActivity(index, !_isCheckedList[index]);
                  setState(() {
                  });
                },
                activeColor: Colors.blue,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 90,
            margin: const EdgeInsets.symmetric(vertical: 10), // Espaçamento entre as atividades
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: const BorderRadius.only(topLeft: Radius.zero, topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aspen,',
                  style: GoogleFonts.getFont('Roboto Condensed',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'March 09, 2024,',
                  style: GoogleFonts.getFont('Roboto Condensed',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Cost: \$${currencyFormatter.format(_budget)} '),
              ],
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> loadActivities(){
    return _activitiesList;
  }

  @override
  void initState(){
    super.initState();
    _budget = double.parse(widget.plan['cost']);
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
                      height: MediaQuery.of(context).size.height / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image:
                                AssetImage(widget.plan['imgPath']),
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
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        width: MediaQuery.of(context).size.width * 0.94,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.zero, topRight: Radius.zero, bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                            color: Colors.black38,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.plan['destiny'],
                                      style: GoogleFonts.getFont('Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                          color: Colors.white),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      width: MediaQuery.of(context).size.width * 0.85,

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              const Icon(Icons.calendar_month_sharp),
                                              Text(

                                                '${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.plan['startDate']!))} - '
                                                    '${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.plan['endDate']!))}',
                                                style: GoogleFonts.getFont(
                                                    'Roboto Condensed',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),
                                          Container(
                                            child: Row(
                                              children: [
                                                const Icon(Icons.people_outline,
                                                    color: Colors.white),
                                                Text(
                                                  ' 4',
                                                  style: GoogleFonts.getFont(
                                                      'Roboto Condensed',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your travel plan',
                        style: GoogleFonts.getFont('Roboto Condensed',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: (){
                          addNewActivity();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Add new activity',
                                  style: GoogleFonts.getFont('Roboto Condensed',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: List.generate(_activitiesListContent.length, (index) => _activitiesListContent[index]),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Budget',
                        style: GoogleFonts.getFont('Roboto Condensed',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black38),
                      ),
                    ),
                    Text(
                      currencyFormatter.format(_budget),
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  print('book now');
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 3,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      'Arquivar',
                      style: GoogleFonts.getFont("Roboto Condensed",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
