import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/src/models/actividad_model.dart';
import 'package:to_do_list/src/styles/styles.dart' as style;
import 'package:to_do_list/src/provider/list_provider.dart';
import 'package:to_do_list/src/search/actividadSearchDelegate.dart';
import 'package:to_do_list/src/widgets/listaActividades.dart'; 

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

   final _formkey = GlobalKey<FormState>();
   final _formkey2 = GlobalKey<FormState>();
   String titulo = "";
   String descripcion = "";
   int? limite; 
   
  @override
  Widget build(BuildContext context)  { 

    final listaActividades = Provider.of<ListaProvider>(context).actividades;
    final listaProvider = Provider.of<ListaProvider>(context);  
  
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text(" To Do List"),
              actions: [
                  IconButton(
                    onPressed: (){
                        showSearch(context: context, delegate: ActividadSearchDelegate());
                    },
                    icon: Icon(Icons.search)
                 )
              ],
          ),
          body: Stack(
              children: [
                  _background(),
                  ListaActividades(listaActividades),
              ],
          ),
          floatingActionButton: SpeedDial(
              backgroundColor: Colors.blue,
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.play_circle_fill_rounded),
                  backgroundColor: Colors.red[300],
                  label: "Frases aleatorias",
                  onTap: () async {
                      await _showDialog(context, listaProvider);   
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.add_comment),
                  
                  label: "Agregar Actividad",
                  onTap: () => _agregarActividad(),
                ),
              ],
            )
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, ListaProvider listaProvider) {
    return showDialog(
                        context: context,
                        builder: (BuildContext context){
                            return AlertDialog(
                                actions: [
                                    TextButton(
                                        onPressed: (){
                                            Navigator.of(context).pop(false); 
                                        },
                                        child: Text("Cancelar")
                                    ),
                                    TextButton(
                                        onPressed: (){
                                            if(_formkey2.currentState!.validate()){
                                                _formkey2.currentState!.save();
                                                listaProvider.getCatsFacts(limite!);
                                                Navigator.of(context).pop(false); 
                                            }
                                        },
                                        child: Text(" Generar")
                                    ) 
                                ],
                                content: Column( 
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                         Text(" Digite el numero de frases", style: style.estiloText1,),
                                         SizedBox(height: 15.0,),
                                         Form(
                                           key: _formkey2,
                                           child: TextFormField(
                                               keyboardType: TextInputType.number,
                                               validator: (val){
                                                   int? lim = int.tryParse(val!);  
                                         
                                                   if(lim != null){
                                                     return null; 
                                                   }else{
                                                     return "Ingrese un numero";
                                                   } 
                                                    
                                               },
                                               onSaved: (val) => limite = int.parse(val!),  
                                           ),
                                         ),
                                     ],
                                ),
                            );
                        }
                    );
  }


  Widget _background(){
      return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: style.gradiante,
          ),
      ); 
  }

  Future<void> _agregarActividad() async { 
   final listaProvider = Provider.of<ListaProvider>(context, listen: false);  

      return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context1, setState) {
            return AlertDialog(
              elevation: 5.0,
              content: Container(
                  child: SingleChildScrollView(
                      child: Column(
                          children: [ 
                               Text(" Agregar nueva actividad ", style: style.estiloText1,), 
                               SizedBox(height: 20.0,),
                               _formActividad()
                          ],
                      ),
                  ),
              ),
              actions: [ 
                  TextButton(
                     onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancelar"), 
                 ), 
                  TextButton(
                     onPressed: (){ 
                          if(_formkey.currentState!.validate()){
                              _formkey.currentState!.save();
                              ActividadModel actividadModel = ActividadModel(titulo: titulo, descripcion: descripcion, activa: 1); 
                              listaProvider.nuevaActividad(actividadModel);
                              Navigator.of(context).pop(false); 
                          }       
                     },
                    child: Text("GUARDAR"), 
                 )
              ],
            );
          },
        );
      },
    );
  }  

  Widget _formActividad(){
        return Form(
          key: _formkey,
          child: Column(
              children: [
                  TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      onSaved: (val) => titulo = val!,
                      validator: (val) {
                          return val!.isNotEmpty? null : "Debe agregar un titulo"; 
                      },
                      decoration: InputDecoration(
                          hintText: "Titulo de la actividad",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      ),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      onSaved: (val) => descripcion = val!,
                      validator: (val) {
                          return val!.isNotEmpty? null : "Debe agregar una descripcion"; 
                      },
                      decoration: InputDecoration(
                          hintText: "Descripcion",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                      ),
                  ),
              ],
          ),
      );

  }
}