import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/screens/trip_plan_page.dart';
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
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  final NumberFormat currencyFormatter =
  NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  List _ongoingPlans = [];
  List _pastPlans = [];

  Future<void> readSavedPlans() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/travel_plans.json');

      if (await file.exists()) {
        final contents = await file.readAsString();

        final data = json.decode(contents);

        setState(() {
          _ongoingPlans = data['ongoingPlans'];
          _pastPlans = data['pastPlans'];
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
    routeObserver.unsubscribe(this);

    _tabController.dispose();
    super.dispose();
  }



  @override
  void didPopNext() {
    print("Atualizando planos ao retornar para a página...");
    readSavedPlans(); // Atualiza a lista de planos
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
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      Tab(text: 'Planos Futuros'),
                      Tab(text: 'Planos Realizados'),
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
        )),
      ],
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

                  return GestureDetector(
                    onTap: (){
                      print('Detect');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripPlanPage(
                                  isLightTheme: widget.isLightTheme,
                                  toggleTheme: widget.toggleTheme, plan: activity)));
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

  Widget PastPlans() {
    return _pastPlans.isEmpty
        ? const Text('Load Past Plasns or You not have old plans')
        : Center(
            child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 500,
            child: ListView.builder(
              itemCount: _pastPlans.length,
              itemBuilder: (context, index) {
                var activity = _pastPlans[index];
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(activity['name']),
                    subtitle: Text(
                      activity['description'],
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
                        const SizedBox(height: 20),
                        Text('R\$ ${activity['cost'].toStringAsFixed(2)}'),
                      ],
                    ),
                    leading: Container(
                      width: 90, // Largura da imagem
                      height: 90, // Altura da imagem
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(8), // Bordas arredondadas
                        image: DecorationImage(
                          fit: BoxFit
                              .cover, // Ajusta a imagem para cobrir o espaço disponível
                          image: AssetImage(activity['images']),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
  }
}
