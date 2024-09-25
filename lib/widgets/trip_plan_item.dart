import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripPlanItem extends StatelessWidget {
  final String title;
  final String budget;
  final String image;

  const TripPlanItem({
    super.key,
    required this.title,
    required this.budget,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => PlaceScreen()));
      },
      child: Container(
        width: 240,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.9,
            image: AssetImage(image),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Colors.blue.withOpacity(0.8),
              ),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          // SvgPicture.asset(
                          //   'assets/vectors/star_1_x2.svg',
                          //   width: 20,
                          //   height: 20,
                          // ),
                          // SizedBox(width: 5),
                          Text(
                            'Budget: $budget',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('See details', style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.green)),
                      Icon(Icons.favorite, color: Colors.red),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
