import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'new_plan_screen.dart';

class TripPlansListPage extends StatefulWidget {
  final bool isLightTheme;
  final VoidCallback toggleTheme;

  const TripPlansListPage({
    super.key,
    required this.isLightTheme,
    required this.toggleTheme,
  });

  @override
  State<TripPlansListPage> createState() => _TripPlansPage();
}

class _TripPlansPage extends State<TripPlansListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List _ongoingPlans = [];
  List _pastPlans = [];

  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/travel_plans.json');
    final data = await json.decode(response);
    setState(() {
      print(data);
      _ongoingPlans = data['ongoingPlans'];
      _pastPlans = data['pastPlans'];
      print(_ongoingPlans);
      print(_pastPlans);
    });
  }

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
          _ongoingPlans =
              data['ongoingPlans'];
          _pastPlans =
          data['pastPlans'];
        });
      } else {
        print("Arquivo não encontrado.");
      }
    } catch (e) {
      print("Erro ao ler o arquivo: $e");
    }
  }

  @override
  void initState() {
    readSavedPlans();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 48,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue.shade100,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).iconTheme.color),
                    labelColor:
                        Theme.of(context).appBarTheme.titleTextStyle?.color ??
                            Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: 'Ongoing Plans'),
                      Tab(text: 'Past Plans'),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _ongoingPlans.isNotEmpty ? OngoingPlans() : noPlans(),
                  PastPlans(),
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget noPlans() {
    return Container(
      child: Center(
          child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Sua lista de planos esta vazia',
            style: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
                  Colors.black,
            ),
          ),
          SizedBox(height: 20),
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewPlanScreen(
                          isLightTheme: widget.isLightTheme,
                          toggleTheme: widget.toggleTheme)));
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

  Widget OngoingPlans() {
    print('_items');
    print(_ongoingPlans);
    return Center(
      child: _ongoingPlans != null && _ongoingPlans.isNotEmpty
          ? Container(
        height: 500,
        child: ListView.builder(
          itemCount: _ongoingPlans.length,
          itemBuilder: (context, index) {
            var activity = _ongoingPlans[index];
            print(activity);
            String title = activity['title'];
            String description = activity['description'];
            String cost = activity['cost'];
            //String imagePath = activity['images'] ?? ''; // Verifique se 'images' é nulo

            return Card(
              margin: EdgeInsets.all(5),
              child: ListTile(
                title: Text(title),
                subtitle: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                    SizedBox(height: 20),
                    Text(cost),
                  ],
                ),
                leading: Container(
                  width: 90, // Largura da imagem
                  height: 90, // Altura da imagem
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                    // image: imagePath.isNotEmpty
                    //     ? DecorationImage(
                    //   fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                    //   image: AssetImage(imagePath),
                    // )
                    //     : null, // Evitar erro se 'images' for nulo
                  ),
                ),
              ),
            );
          },
        ),
      )
          : Text('Nenhum plano em andamento encontrado.'),
    );
  }


  Widget PastPlans() {
    return _pastPlans.isEmpty?
    Text('Load Past Plasns or You not have old plans')
        : Center(
      child: Container(
        height: 500,
        child: ListView.builder(
          itemCount: _pastPlans.length,
          itemBuilder: (context, index) {
            var activity = _pastPlans[index];
            return Card(
              margin: EdgeInsets.all(5),
              child: ListTile(
                title: Text(activity['name']),
                subtitle: Text(activity['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                    SizedBox(height: 20),
                    Text('R\$ ${activity['cost'].toStringAsFixed(2)}'),
                  ],
                ),
                leading: Container(
                  width: 90, // Largura da imagem
                  height: 90, // Altura da imagem
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                    image: DecorationImage(
                      fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                      image: AssetImage(activity['images']),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
