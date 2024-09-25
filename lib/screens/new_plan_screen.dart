import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/place_screen.dart';
import '../widgets/appBar_widget.dart';
import 'activity_select_screen.dart';

class NewPlanScreen extends StatefulWidget {
  final bool isLightTheme;
  final VoidCallback toggleTheme;

  const NewPlanScreen({
    super.key,
    required this.isLightTheme,
    required this.toggleTheme,
  });

  @override
  State<NewPlanScreen> createState() => _NewPlanScreen();
}

class _NewPlanScreen extends State<NewPlanScreen> {
  DateTime? startDate;
  DateTime? endDate;
  String? _selectedCountry;
  Map<String, dynamic>? _selectedPlaceData;
  int budget = 0;
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: '\$');
  ScrollController _controller = ScrollController();

  // int dia = data.day;
  // int mes = data.month;
  // int ano = data.year;
  // String nomeDoMes = DateFormat.MMMM('pt_BR').format(data);
  // print("Mês (nome): $nomeDoMes");

  List _items = [];
  List _ongoingPlans = [];
  List _pastPlans = [];
  List<String> _selectedActivities = [];
  Activity? activityObj;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/destination_countries.json');
    final data = await json.decode(response);
    setState(() {
      _items = data['countries'];
    });
  }

  @override
  void initState() {
    readJson();
    readPlans();
  }

  Future<void> _navigateToPlaceScreen(Map<String, dynamic> place) async {
    // Navega para a página de detalhes e aguarda o retorno de um resultado
    final selectedPlace = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceScreen(place: place),
      ),
    );

    // Atualiza o estado se um local foi selecionado
    if (selectedPlace != null) {
      setState(() {
        _selectedPlaceData = selectedPlace;
        _selectedCountry = selectedPlace['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            buildCustomAppBar(context, widget.isLightTheme, widget.toggleTheme),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            opacity: 0.9,
                            image:
                                AssetImage('assets/images/planning_a_trip.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Novo plano de viagem',
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                        ),
                      ),
                      Text(
                        'Escolha um destino e as atividades para sua viagem.',
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Complete os campos abaixo:',
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                    ),
                  ),
                  TextFormField(
                    cursorColor:
                        Theme.of(context).appBarTheme.titleTextStyle?.color ??
                            Colors.black,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      hintText: 'Defina um nome',
                      labelText: 'Nome da viagem',
                    ),
                  ),
                  TextFormField(
                    cursorColor:
                        Theme.of(context).appBarTheme.titleTextStyle?.color ??
                            Colors.black,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      hintText: 'Adcione uma descrição',
                      labelText: 'Descrição da viagem',

                    ),
                  ),

                  // Escolha da data
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 12),
                          Text(
                            'Escolha a data',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 12),
                          FloatingActionButton(
                            onPressed: () {
                              showCustomDateRangePicker(
                                context,
                                dismissible: true,
                                minimumDate: DateTime.now()
                                    .subtract(const Duration(days: 30)),
                                maximumDate: DateTime.now()
                                    .add(const Duration(days: 30)),
                                endDate: endDate,
                                startDate: startDate,
                                backgroundColor: Colors.white,
                                primaryColor: Colors.green,
                                onApplyClick: (start, end) {
                                  setState(() {
                                    endDate = end;
                                    startDate = start;
                                    print(endDate);
                                    print(startDate);
                                    Timer(
                                        Duration(milliseconds: 300),
                                            () => _controller
                                            .jumpTo(_controller.position.maxScrollExtent));
                                  });
                                },
                                onCancelClick: () {
                                  setState(() {
                                    endDate = null;
                                    startDate = null;
                                  });
                                },
                              );
                            },
                            backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor ??
                                Colors.black,
                            tooltip: 'escolha uma data',
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Inicio: ${startDate == null ? '--/--' : DateFormat('yyyy-MM-dd').format(startDate!)}',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Fim: ${endDate == null ? '--/--' : DateFormat('yyyy-MM-dd').format(endDate!)}',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Text(
                'Já podemos escolher o destino?',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
                ),
              ),
              _items.isNotEmpty
                  ? DropdownButton<String>(
                value: _selectedCountry,
                hint: Text("Selecione um destino", style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),),
                isExpanded: true,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                items: _items.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item['name'],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(item['images']),
                            ),
                          ),
                        ),
                        Text(item['name']),
                        GestureDetector(
                          onTap: () async {
                            await _navigateToPlaceScreen(item);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.transparent,
                            child: Icon(Icons.arrow_circle_right_outlined, color: Theme.of(context).iconTheme.color,),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return _items.map<Widget>((item) {
                    return Text(item['name']);
                  }).toList();
                },
                onChanged: (String? newValue) {
                  setState(() {
                    Timer(
                        Duration(milliseconds: 300),
                            () => _controller
                            .jumpTo(_controller.position.maxScrollExtent));
                    if(_selectedCountry != newValue){
                      _activitiesList = [];
                      _activitiesListContent = [];
                      budget = 0;
                    }

                    _selectedCountry = newValue;
                    // Encontre o item correspondente pelo nome e obtenha o custo
                    var selectedItem = _items.firstWhere(
                          (item) => item['name'] == _selectedCountry,
                      orElse: () => null,
                    );

                    // Atualize o budget com o custo encontrado, verificando se o item existe
                    if (selectedItem != null && selectedItem['cost'] is int) {
                      budget = selectedItem['cost'] as int;
                    } else {
                      budget = 0; // Caso o item ou custo não seja encontrado
                    }
                    _selectedPlaceData = _items.firstWhere(
                            (item) => item['name'] == newValue,
                        orElse: () => null);
                  });
                },
              )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                _selectedPlaceData != null
                    ? "Local Selecionado: ${_selectedPlaceData!['name']}"
                    : "Nenhum local selecionado",
                style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
              ),
              SizedBox(height: 12),
              // Center(
              //   child: _selectedPlaceData != null
              //       ? Container(
              //     height: 500,
              //     child: ListView.builder(
              //       itemCount: _selectedPlaceData?['activities'].length,
              //       itemBuilder: (context, index) {
              //         var activity = _selectedPlaceData?['activities'][index];
              //         return Card(
              //           margin: EdgeInsets.all(5),
              //           child: ListTile(
              //             title: Text(activity['name']),
              //             subtitle: Text(activity['description'],
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //             trailing: Column(
              //               children: [
              //                 Container(
              //                   width: 20,
              //                   height: 20,
              //                   color: Colors.yellow,
              //                 ),
              //                 SizedBox(height: 20),
              //                 Text('R\$ ${activity['cost'].toStringAsFixed(2)}'),
              //               ],
              //             ),
              //             leading: Container(
              //               width: 90, // Largura da imagem
              //               height: 90, // Altura da imagem
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8), // Bordas arredondadas
              //                 image: DecorationImage(
              //                   fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
              //                   image: AssetImage(activity['images']),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ): Text(''),
              // ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: List.generate(_activitiesListContent.length, (index) => _activitiesListContent[index]),
                ),
              ),
              Center(
                child: _selectedPlaceData != null
                    ? Column(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          addNewActivity();
                          Timer(
                              Duration(milliseconds: 300),
                                  () => _controller
                                  .jumpTo(_controller.position.maxScrollExtent));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Adicionar nova atividade',
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
                    ),
                    SizedBox(height: 20),
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
                          Text(
                            currencyFormatter.format(budget),
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    :SizedBox(height: 20),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          onTap: (index) async {
            index == 0 ? Navigator.pop(context) : savePlan(generatePlan());
          },
          //fixedColor: Colors.cyan,
          currentIndex: 0,
          //unselectedItemColor: Colors.black38,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.arrow_circle_left_outlined,
                color: Theme.of(context).iconTheme.color),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.save_alt_rounded,
                color: Theme.of(context).iconTheme.color), label: ''),
          ],
        ),
      ),
    );
  }

  List<Widget> _activitiesList = [];
  List<Widget> _activitiesListContent = [];
  bool isChecked = false;
  double _budget = 0.0;


  void addNewActivity() {
    _activitiesList.add(activityEmpty(_activitiesList.length));
    setState(() {
      _activitiesListContent = _activitiesList;
    });
  }

  Widget activityEmpty(int index) {
    print('nova atividae');
    return Container(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5), // Espaçamento entre as atividades
            width: MediaQuery.of(context).size.width * 0.7,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      print('set activity ${index}');
                      await _navigateToActivityScreen(_selectedPlaceData!, index);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline_rounded, color: Theme.of(context).iconTheme.color,),
                        const SizedBox(width: 10),
                        Text(
                          'Slecione uma atividade',
                          style: GoogleFonts.getFont('Roboto Condensed',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Delete item ${index}");
                    setState(() {
                      _activitiesList.removeAt(index);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget setActivity(int index, String name){
    print(name);
    print(_activitiesListContent);
    print(_activitiesList);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(name),
    );
  }

  Future<void> _navigateToActivityScreen(Map<String, dynamic> place, int index) async {
    // Navega para a página de detalhes e aguarda o retorno de um resultado
    final activity = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityDetails(place: place),
      ),
    );



    // Atualiza o estado se um local foi selecionado
    if (activity != null) {
      setState(() {
        _activitiesList[index] = setActivity(index, activity['name']);
        budget = budget + (activity['cost'] as int);
        List<String> ac = [activity['name'], activity['ongoing']];
        _selectedActivities[index] = ac.toString();
      });
    }
  }




  readPlans() async {
    final String response =
    await rootBundle.loadString('assets/travel_plans.json');
    final data = await json.decode(response);
    setState(() {
      _ongoingPlans = data['ongoingPlans'];
      _pastPlans = data['pastPlans'];
      print(_ongoingPlans);
      print(_pastPlans);
    });
  }


  TravelPlan generatePlan(){
    return TravelPlan(
      state: 'ongoing',
      title: "Viagem para a Praia",
      description: "Um plano de viagem incrível para a praia.",
      destiny: _selectedCountry!,
      cost: _budget.toString(),
      endDate: endDate.toString(),
      startDate: startDate.toString(),
      //selectedActivities: _selectedActivities,
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

    // Verifica se já existe um plano com o mesmo título
    bool planExists = false;

    for (var i = 0; i < jsonData['ongoingPlans'].length; i++) {
      if (jsonData['ongoingPlans'][i]['title'] == plan.title) {
        // Se encontrar um plano com o mesmo título, atualiza
        jsonData['ongoingPlans'][i] = plan.toJson();
        planExists = true;
        break;
      }
    }

    // Se não existir, adiciona o novo plano
    if (!planExists) {
      jsonData['ongoingPlans'].add(plan.toJson());
    }

    print('NOVO ou ATUALIZADO:');
    print(jsonData);

    // Salva o JSON atualizado de volta no arquivo
    await file.writeAsString(json.encode(jsonData));
  }


}


class TravelPlan {
  String state;
  String title;
  String description;
  String destiny;
  String cost;
  String startDate;
  String endDate;
  //List<String> selectedActivities;

  TravelPlan({
    required this.state,
    required this.title,
    required this.description,
    required this.destiny,
    required this.cost,
    required this.startDate,
    required this.endDate,
    //required this.selectedActivities,
  });

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'title': title,
      'description': description,
      'destiny': destiny,
      'cost': cost,
      'startDate': startDate,
      'endDate' : endDate,
     // 'selectedActivities': selectedActivities.map((a) => a.toJson()).toList(),
    };
  }
}

class Activity {
  String activityName;
  String state;

  Activity({required this.activityName, required this.state});

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'state': state,
    };
  }
}

