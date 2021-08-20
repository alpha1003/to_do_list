import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/src/provider/cats_provider.dart';
import 'package:to_do_list/src/provider/list_provider.dart';
import 'package:to_do_list/src/widgets/listaActividades.dart'; 

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  
   
  @override
  Widget build(BuildContext context)  { 

    final actividades = Provider.of<ListaProvider>(context).listaActividades;
    final descripciones = Provider.of<ListaProvider>(context).listaDescripcion; 

    final listaProvider = Provider.of<ListaProvider>(context);  
    final catsProvider  = Provider.of<CatsProvider>(context);



    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text(" To Do List"),
              actions: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search)
                 )
              ],
          ),
          body: ListaActividades(actividades, descripciones),
          floatingActionButton: SpeedDial(
              backgroundColor: Colors.green,
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.play_circle_fill_rounded),
                  backgroundColor: Colors.red[300],
                  label: "Frases aleatorias",
                  onTap: (){
                      catsProvider.getCatsFacts(10); 
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.add_comment),
                  
                  label: "Agregar Actividad",
                  onTap: (){
                      setState(() {
                      listaProvider.setListaActividades("alpha", "Omega");
                  });
                  },
                ),
              ],
            )
      ),
    );
  }


  Widget _background(){
      return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient( 
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Color.fromRGBO(58, 28, 113, 44),
                      Color.fromRGBO(215, 109, 119, 84),
                      Color.fromRGBO(255, 175, 123, 100) 
                  ]
              ),
          ),
      ); 
  } 
}