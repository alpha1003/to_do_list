import 'package:flutter/material.dart'; 


TextStyle estiloText1 = TextStyle(
    color: Colors.orange, 
    fontWeight: FontWeight.bold,
    fontFamily: "alpha",
    fontSize: 25.0
);

TextStyle estiloText2 = TextStyle(
    fontFamily: "alpha",
    fontSize: 20.0,
    color: Colors.black,

);

TextStyle estiloText3 = TextStyle(
    fontFamily: "alpha",
    fontSize: 20.0,
    color: Colors.white,

);


Color colorCuadro = Color.fromRGBO(255, 255, 255, 0.6); 

LinearGradient gradiante = LinearGradient( 
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Color.fromRGBO(0, 90, 167, 44),
                      Color.fromRGBO(255, 253, 228, 100) 
                  ]
              );