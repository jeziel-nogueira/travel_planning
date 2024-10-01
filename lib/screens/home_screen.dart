import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/screens/trip_list_page.dart';
import 'package:untitled/screens/trip_plan_page.dart';
import 'package:untitled/screens/trips_plans_list_page.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/bottomNavigationBar_widget.dart';
import 'new_plan_screen.dart';



class HomeScreen extends StatefulWidget {
  final bool isLightTheme;
  final VoidCallback toggleTheme;

  const HomeScreen({
    super.key,
    required this.isLightTheme,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with WidgetsBindingObserver{


  int _selectedIndex = 0;
  late List<Widget> _screens;

  List _ongoingPlans = [];

  Future<void> readSavedPlans() async {
    try {
      // Obtenha o diretório do sistema de arquivos onde o plano foi salvo
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/travel_plans.json');

      // Verifique se o arquivo existe
      if (await file.exists()) {
        // Leia o conteúdo do arquivo
        final contents = await file.readAsString();

        // Converta o conteúdo JSON para um objeto do Dart
        final data = json.decode(contents);

        // Atualize o estado com os planos carregados
        setState(() {
          _ongoingPlans = data['ongoingPlans'];
        });
        print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
      } else {
        print("Arquivo não encontrado.");
      }
    } catch (e) {
      print("Erro ao ler o arquivo: $e");
    }
  }

  final NumberFormat currencyFormatter =
  NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Opcionalmente, chama readSavedPlans toda vez que as dependências mudarem
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove o observador
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Recarrega os planos quando a tela volta a ser visível
      readSavedPlans();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Adiciona o observador
    readSavedPlans();
    _screens = [
      TripListPage(),
      TripPlansListPage(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme),
      TripPlansListPage(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      readSavedPlans();
    });
  }

  Widget OngoingPlans() {
    print('_items');
    print(_ongoingPlans);
    return Center(
      child: _ongoingPlans != null && _ongoingPlans.isNotEmpty
          ? Container(
        height: (90*_ongoingPlans.length)*1.0,
        child: ListView.builder(
          itemCount: _ongoingPlans.length,
          itemBuilder: (context, index) {
            var activity = _ongoingPlans[index];
            print(activity);
            String title = activity['title'];
            String description = activity['description'];
            String cost = activity['cost'];

            return GestureDetector(
              onTap: () async {
                final result = await
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripPlanPage(
                            isLightTheme: widget.isLightTheme,
                            toggleTheme: widget.toggleTheme, plan: activity)));
                if (result != null) {
                  readSavedPlans();
                }else{
                  readSavedPlans();
                }
              },
              child: Card(
                color: Theme.of(context).appBarTheme.backgroundColor,
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    children: [
                      const SizedBox(height: 5),
                      Icon(Icons.arrow_circle_right_outlined,
                          size: 30,
                          color: Theme.of(context).iconTheme.color),
                      const SizedBox(height: 5),
                      Text(currencyFormatter
                          .format(double.parse(cost))),
                    ],
                  ),
                  leading: Container(
                    width: 90, // Largura da imagem
                    height: 120, // Altura da imagem
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(8), // Bordas arredondadas
                        image: DecorationImage(
                          fit: BoxFit
                              .cover, // Ajusta a imagem para cobrir o espaço disponível
                          image: AssetImage(activity['imgPath']),
                        )),
                  ),
                ),
              ),
            );
          },
        ),
      )
          : const Text('Nenhum plano em andamento encontrado.'),
    );
  }
  Widget noPlans() {
    return Container(
      child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Sua lista de planos esta vazia',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
                      Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Text(
                  'Vamos criar um plano?',
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
                        Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, // foreground (text) color
                  backgroundColor:
                  Theme.of(context).iconTheme.color, // background color
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewPlanScreen(
                              isLightTheme: widget.isLightTheme,
                              toggleTheme: widget.toggleTheme)));
                  if(result){
                    setState(() {
                      readSavedPlans();
                    });
                  }
                },
                child: Text(
                  'Novo Plano',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
                          Colors.black),
                ),
              ),
            ],
          )),
    );
  }

  Widget homeContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Container( child: TripPlansListPage(),),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Planos Recentes',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,)
                ),
                Text(
                  'ver todos',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Theme.of(context).iconTheme.color),
                ),
              ],
            ),
            SizedBox( height: 12),
            _ongoingPlans.isNotEmpty ? OngoingPlans() : noPlans(),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Melhores Destinos',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,)
                ),
                Text(
                  'ver todos',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color:  Theme.of(context).iconTheme.color),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Atividades em Destaque',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,)
                ),
                Text(
                  'ver todos',
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Theme.of(context).iconTheme.color),
                ),
              ],
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  opacity: 0.9,
                                  image: AssetImage(
                                      'assets/images/Coeurdes Alpes.png'),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Location title'),
                                Row(
                                  children: [
                                    Text(
                                      'spaceAround ',
                                      style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black26),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildCustomAppBar(context, widget.isLightTheme, widget.toggleTheme),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: _selectedIndex == 0 ? homeContent() : _screens[_selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).iconTheme.color,
        onPressed: () async {
          final result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPlanScreen(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme)));
          if(result){
            setState(() {
              readSavedPlans();
            });
          }
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
