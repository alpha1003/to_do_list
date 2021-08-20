import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 



class ListaProvider with ChangeNotifier {


    List<String> listaActividades = [];
    List<String> listaDescripcion = []; 
    ListaProvider(){
      this.getlistaActividades(); 
    }


    getlistaActividades() async {

        SharedPreferences prefs = await SharedPreferences.getInstance(); 
        listaActividades = prefs.getStringList("listaA") ?? [];  
        listaDescripcion = prefs.getStringList("listaD") ?? [];
        
        notifyListeners(); 
    } 

    setListaActividades(String titulo, String descripcion) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
        listaActividades = prefs.getStringList("listaA") ?? [];
        listaDescripcion = prefs.getStringList("listaD") ?? [];
        listaActividades.add(titulo);
        listaDescripcion.add(descripcion); 
        prefs.setStringList("listaA", listaActividades);
        prefs.setStringList("listaD", listaDescripcion); 
        notifyListeners();
    }  

    editarActividad(String descripcion, int index) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        listaDescripcion = prefs.getStringList("listaD") ?? []; 
        listaDescripcion[index] = descripcion; 
        prefs.setStringList("listaD", listaDescripcion); 
        notifyListeners();
    }

    eliminarActividad(int index) async {

        SharedPreferences prefs = await SharedPreferences.getInstance(); 
        listaActividades = prefs.getStringList("listaA") ?? [];
        listaDescripcion = prefs.getStringList("listaD") ?? []; 
        listaActividades.removeAt(index); 
        listaDescripcion.removeAt(index);
        prefs.setStringList("listaA", listaActividades);
        prefs.setStringList("listaD", listaDescripcion); 
        notifyListeners();


    }




}