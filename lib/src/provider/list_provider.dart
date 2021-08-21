import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/models/actividad_model.dart';
import 'package:to_do_list/src/provider/db_provider.dart'; 



class ListaProvider with ChangeNotifier {

    List<ActividadModel> actividades = [];
    
    ListaProvider(){
      this.getlistaActividades(); 
    } 


    nuevaActividad(ActividadModel actividad) async {


        final id = await DBProvider.db.nuevaActividad(actividad);
        actividad.id = id; 
        this.actividades.add(actividad); 
        notifyListeners(); 

    }

    getlistaActividades() async { 

        final actividades = await DBProvider.db.getTodosLosActividades(); 
        this.actividades = [...actividades]; 
        notifyListeners(); 
    }  

    editarActividad(ActividadModel actividad) async {
        await DBProvider.db.updateActividad(actividad); 
        notifyListeners();
    }

    eliminarActividad(int index) async {
       await DBProvider.db.deleteActividad(index);
       this.getlistaActividades();
       notifyListeners(); 
    }




}