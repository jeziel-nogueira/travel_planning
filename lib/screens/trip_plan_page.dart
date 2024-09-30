import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'new_plan_screen.dart';

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

  List<Widget> _activitiesListContent = [];
  bool? planState;
  int isUpdate = 0;
  List<dynamic> _selectedActivities = [];


  @override
  void initState(){
    super.initState();
    print(widget.plan);
    _budget = double.parse(widget.plan['cost']);
    widget.plan['statte'] == 'ongoing'?
        planState = true
        : planState = false;

    _selectedActivities = json.decode(widget.plan['selectedActivities']);
    manipulateActivities(_selectedActivities);
  }

  void manipulateActivities(List<dynamic> selectedActivities) {
    setState(() {
      // Certifique-se de que _selectedActivities tenha o mesmo tamanho que selectedActivities
      if (_selectedActivities.isEmpty) {
        _selectedActivities = List<String>.from(selectedActivities);
      }

      // Limpar _activitiesListContent antes de reconstruí-lo
      _activitiesListContent.clear();

      for (var i = 0; i < selectedActivities.length; i++) {
        // Decodifica a string JSON para um mapa
        Map<String, dynamic> activity = jsonDecode(selectedActivities[i]);

        // Cria um widget (ex: um Card ou ListTile) para a atividade
        Widget activityWidget = Card(
          child: ListTile(
            leading: Image.asset(activity['images']), // Exibe o thumbnail da atividade
            title: Text(activity['name']),
            subtitle: Text(activity['description']),
            trailing: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Alterna o estado da atividade
                      if (activity['state'] == 'ongoing') {
                        activity['state'] = 'past';
                      } else {
                        activity['state'] = 'ongoing';
                      }

                      // Atualizando a lista original _selectedActivities, se ela tiver elementos suficientes
                      if (i < _selectedActivities.length) {
                        String updatedActivityJson = jsonEncode(activity);
                        _selectedActivities[i] = updatedActivityJson;

                        // Opcional: exibir a lista atualizada
                        print(_selectedActivities);
                        manipulateActivities(_selectedActivities);
                      } else {
                        print("Erro: Índice fora do intervalo de _selectedActivities.");
                      }
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(Icons.add),
                        Text(activity['state'] == 'ongoing' ? 'Pendente' : 'Concluido'),
                      ],
                    ),
                  ),
                ),
                Text('Custo: \$${activity['cost']}')
              ],
            ),
          ),
        );

        // Adiciona o widget atualizado à lista
        _activitiesListContent.add(activityWidget);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        widget.plan['title'],
                        style: GoogleFonts.getFont('Roboto Condensed',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {

                            if(widget.plan['state'] == 'ongoing'){
                              widget.plan['state'] = 'past';
                            }else{
                              widget.plan['state'] = 'ongoing';
                            }
                            planState = !planState!;
                          });
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
                                planState != true?
                                Text(
                                  'Marcar como Cuncluido',
                                  style: GoogleFonts.getFont('Roboto Condensed',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                ):Text(
                                  'Marcar como Não Cuncluido',
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
          color: Theme.of(context).appBarTheme.backgroundColor,
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
                  savePlan(generatePlan());
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

  TravelPlan generatePlan() {
    List<String> selectedActivities = List<String>.from(widget.plan['selectedActivities'].values);

    return TravelPlan(
        state: widget.plan['state'],
        title: widget.plan['title'],
        description: widget.plan['description'],
        destiny: widget.plan['destiny'],
        cost: widget.plan['cost'],
        endDate: widget.plan['endDate'],
        startDate: widget.plan['startDate'],
        destinyID: widget.plan['destinyID'],
        selectedActivities: selectedActivities,
        imgPath: widget.plan['imgPath'],
    );
  }

  Future<void> savePlan(TravelPlan plan) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/travel_plans.json');

    // Carrega os dados existentes
    Map<String, dynamic> jsonData = {
      'plans_model': [],
      'ongoingPlans': [],
      'pastPlans': [],
    };

    if (await file.exists()) {
      final contents = await file.readAsString();
      jsonData = json.decode(contents);
    }

    // Remove o plano de ongoingPlans ou pastPlans se já existir
    jsonData['ongoingPlans'] = jsonData['ongoingPlans'].where((p) => p['title'] != plan.title).toList();
    jsonData['pastPlans'] = jsonData['pastPlans'].where((p) => p['title'] != plan.title).toList();

    if (plan.state == 'ongoing') {
      print('Adicionando plano em ongoingPlans');
      jsonData['ongoingPlans'].add(plan.toJson());
    } else if (plan.state == 'past') {
      print('Adicionando plano em pastPlans');
      jsonData['pastPlans'].add(plan.toJson());
    }

    // Salva o JSON atualizado de volta no arquivo
    await file.writeAsString(json.encode(jsonData));
  }


}
