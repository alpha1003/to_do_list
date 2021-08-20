import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/src/models/reponse_model.dart';
import 'package:to_do_list/src/provider/list_provider.dart'; 


class CatsProvider with ChangeNotifier { 

    final  String _url = "https://catfact.ninja/facts?limit="; 
    List<Response> respuestas = []; 
    final listaProvider = ListaProvider(); 


  

    getCatsFacts(int limit) async {
      
        final url = _url + limit.toString(); 

        final res = await http.get(Uri.parse(url));  

        final response = responseFromJson(res.body); 

        

         


        notifyListeners();




    }

    



}