import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/src/models/reponse_model.dart';
import 'package:to_do_list/src/models/actividad_model.dart';
import 'package:to_do_list/src/provider/db_provider.dart'; 
import 'package:http/http.dart' as http;



class ListaProvider with ChangeNotifier {

    List<ActividadModel> actividades = [];
    List<ActividadModel> actividades2 = [];
    final  String _url = "https://catfact.ninja/facts?limit="; 
    
    ListaProvider(){
      this.getlistaActividades(); 
    } 


    
    getCatsFacts(int limit) async { 

        actividades.clear();
      
        final url = _url + limit.toString(); 
        final res = await http.get(Uri.parse(url));  
        final response = responseFromJson(res.body); 

        response.data.forEach((element) { 
            final act = ActividadModel(titulo: element.length.toString(), descripcion: element.fact, activa: 1);
            actividades.add(act);
        });

        notifyListeners();

    }


    nuevaActividad(ActividadModel actividad) async { 

        this.getlistaActividades(); 
        final id = await DBProvider.db.nuevaActividad(actividad);
        actividad.id = id; 
        this.actividades.add(actividad); 
        notifyListeners(); 

    } 

    buscarActividad(String descripcion) async {
        
      final actividades = await DBProvider.db.buscarDescripcion(descripcion);
      actividades2 = [...actividades];
      notifyListeners();
      
    }



    getlistaActividades() async { 

        final actividades = await DBProvider.db.getTodosLosActividades(); 
        this.actividades = [...actividades]; 
        notifyListeners(); 
    }  

    editarActividad(ActividadModel actividad) async {
        await DBProvider.db.updateActividad(actividad); 
        this.getlistaActividades();
        notifyListeners();
    }

    eliminarActividad(int index) async {
       await DBProvider.db.deleteActividad(index);
       this.getlistaActividades();
       notifyListeners(); 
    }




}