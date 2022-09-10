import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
myStyle(double? size, Color? color,[FontWeight? fw]){
  return GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

String apiKey = "267508c46aba4122b6dde617e7698d9c";
String baseUrl = "https://newsapi.org/";