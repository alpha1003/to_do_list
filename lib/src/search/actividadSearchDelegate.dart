import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/src/provider/list_provider.dart';
import 'package:to_do_list/src/widgets/listaActividades.dart'; 

class ActividadSearchDelegate extends SearchDelegate {

   @override
  String? get searchFieldLabel => "Buscar Actividad";

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
        IconButton(
          icon: Icon( Icons.clear ),
          onPressed: () => query = '',
        )
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
   return IconButton(
        icon: Icon( Icons.arrow_back ),
        onPressed: () {
          close(context, null );
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
      return Container(
          child: Center(
            child: Icon( Icons.note_add, color: Colors.black38, size: 130, ),
          ),
        );
    }

  @override
  Widget buildSuggestions(BuildContext context)  {

     if( query.isEmpty ) {
        return _emptyContainer();
      } 

      final listaProvider = Provider.of<ListaProvider>(context); 
      listaProvider.buscarActividad(query); 

      return ListaActividades(listaProvider.actividades2);


  }



}