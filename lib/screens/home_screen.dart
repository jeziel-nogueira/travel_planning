import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/trip_list_page.dart';
import 'package:untitled/screens/trips_plans_list_page.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/bottomNavigationBar_widget.dart';
import '../widgets/trip_plan_item.dart';
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

class _HomeScreen extends State<HomeScreen> {


  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      TripListPage(),
      TripPlansListPage(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme),
      TripPlansListPage(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TripPlanItem(
                        title: 'Go Alley Palace',
                        budget: '\$1.340,27',
                        image: 'assets/images/Alley Palace.png'),
                    SizedBox(
                      width: 16,
                    ),
                    TripPlanItem(
                        title: 'Coeurdes Alpes',
                        budget: '\$1.340,27',
                        image: 'assets/images/Coeurdes Alpes.png'),
                  ],
                ),
              ),
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
        //child: _selectedIndex == 0 ? Text('data'):Text('111111'),
        child: _selectedIndex == 0 ? homeContent() : _screens[_selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).iconTheme.color,
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPlanScreen(isLightTheme: widget.isLightTheme, toggleTheme: widget.toggleTheme)));
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
