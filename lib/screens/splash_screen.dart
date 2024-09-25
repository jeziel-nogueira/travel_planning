import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 93, 23, 48),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/capa.jpg'),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Explore',
                style: GoogleFonts.getFont('Kaushan Script',
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    color: Colors.white),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.getFont("Montserrat",
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            children: [
                              TextSpan(
                                text: 'Planeje sua',
                                style: GoogleFonts.getFont("Montserrat",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                height: 1.3),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: 'Viagem dos Sonhos',
                                style: GoogleFonts.getFont("Montserrat",
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ]),
                      )),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder:
                    // (context) => HomeScreen()));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Center(
                          //child: LoginPopup(),
                        );
                      },
                    );
                  },
                  child:
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue
                    ),
                    child: Center(
                      child: Text(
                        'Explore',
                        style: GoogleFonts.getFont("Roboto Condensed",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
