import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class PlaceScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceScreen({super.key, required this.place});

  @override
  State<PlaceScreen> createState() => _PlaceScreen();
}

class _PlaceScreen extends State<PlaceScreen> {

  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: '\$');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
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
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image:
                            AssetImage(widget.place['images']),
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
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      spreadRadius: 4)
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).iconTheme.color,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 4)
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.place['name'],
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                      ),
                      Text(
                        'Show Map',
                        style: GoogleFonts.getFont('Roboto Condensed',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '4.5 (354 Reviews)',
                      style: GoogleFonts.getFont('Roboto Condensed',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        color:  Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  widget.place['description'],
                  style: GoogleFonts.getFont('Roboto Condensed',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 29),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ativdades',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [

                      SizedBox(height: 20),
                      Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: widget.place['activities'].length,
                          itemBuilder: (context, index) {
                            var activity = widget.place['activities'][index];
                            return Card(
                              color: Theme.of(context).iconTheme.color,
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                title: Text(activity['name']),
                                subtitle: Text(activity['description'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text('R\$ ${activity['cost'].toStringAsFixed(2)}'),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
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
                    Text(
                      currencyFormatter.format((widget.place['cost'] as int)),
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context, widget.place);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.8,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).iconTheme.color
                  ),
                  child: Center(
                    child: Text(
                      'Selecionar Destino',
                      style: GoogleFonts.getFont("Roboto Condensed",
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
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

  Widget _buildCard({required String assetPath, required String text}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.fromLTRB(0, 14, 0, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: 30,
              height: 28,
              child: SvgPicture.asset(assetPath),
            ),
            Padding(
              padding: EdgeInsets.only(right: 1.3),
              child: Text(
                text,
                style: GoogleFonts.getFont('Roboto Condensed',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black26),
              ),
            )
          ],
        ),
      ),
    );
  }
}
