import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/src/provider/list_provider.dart'; 
import 'package:to_do_list/src/styles/styles.dart' as style;

class ListaActividades extends StatelessWidget { 

  final List<String> actividades; 
  final List<String> descripciones;  
  


  const ListaActividades(this.actividades, this.descripciones);

  @override
  Widget build(BuildContext context) { 
    
    final listaProvider = Provider.of<ListaProvider>(context);

    return ListView.builder(
      itemCount: actividades.length,
      itemBuilder: (BuildContext context, int index){

          return _Actividad(actividad: actividades[index], descripcion: descripciones[index], index: index,);

      }
    );
  }
}

class _Actividad extends StatelessWidget {

  final String actividad; 
  final String descripcion; 
  final int index; 

  const _Actividad({ required this.actividad, required this.descripcion, required this.index}); 
  
  
  
  @override
  Widget build(BuildContext context) { 

    final listaProvider = Provider.of<ListaProvider>(context);
    
    return Dismissible(
      key: UniqueKey(),
      background: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
              color: Colors.red,
          ),
          
          child: Row(
            children: [
              SizedBox(width: 40.0,),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Text("Eliminar"),
                     Icon(Icons.delete, size: 30.0,),
                  ],
              ),
            ],
          ),
        ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
          return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Desea eliminar el item?"),
                  title: Text("Confirmacion"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("NO")),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("SÍ")),
                  ],
                );
            } ,
          );
      },
      onDismissed: (direction) {
           listaProvider.eliminarActividad(index); 
         },
      child: Card(
         
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        elevation: 5.0,
        shape: StadiumBorder(),
        child: ListTile(
        enabled: true,             
            title: Text(actividad, style: style.estiloText1,),
            subtitle: Text(descripcion, style: style.estiloText2,),
            trailing: IconButton(
              onPressed: (){},
              icon: Icon(Icons.check),
            ),
            onTap: () {

                _editarDescripcion(context);

            } ,
        ),
      ), 
    );
  } 

  Future<void> _editarDescripcion(BuildContext context) async { 

      final listaProvider = Provider.of<ListaProvider>(context, listen: false);
      String text = descripcion; 
      
       return  showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                        children: [
                            TextFormField(
                                
                                initialValue: descripcion,
                                onChanged: (t){
                            
                                    text = t; 
                                },
                            )
                        ],
                    ),
                  ),
                  title: Text(actividad),
                  actions: [
                         TextButton(
                            onPressed: () {
                                listaProvider.editarActividad(text, index);
                                Navigator.of(context).pop(false); 
                            },
                            child: Text("Guardar"),
                      )
                  ],
                );
            } ,
          );
  }
}