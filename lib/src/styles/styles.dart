import 'package:flutter/material.dart'; 


TextStyle estiloText1 = TextStyle(
    color: Colors.black, 
    fontWeight: FontWeight.w500,
    fontFamily: "alpha",
    fontSize: 23.0
);

TextStyle estiloText2 = TextStyle(
    fontFamily: "alpha",
    fontSize: 20.0,
    color: Colors.black,

); 


Color colorCuadro = Color.fromRGBO(255, 193, 20, 0.6); 

LinearGradient gradiante = LinearGradient( 
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Color.fromRGBO(0, 90, 167, 44),
                      Color.fromRGBO(255, 253, 228, 100) 
                  ]
              );