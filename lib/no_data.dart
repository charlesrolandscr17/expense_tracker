import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.circleXmark,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "No data",
            style: GoogleFonts.aboreto(
                textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
          ),
        ],
      ),
    );
  }
}
