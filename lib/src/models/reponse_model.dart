import 'package:meta/meta.dart';
import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Response({    
        required this.data,
    });

    List<Datum> data;
   

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
     
    };
}

class Datum {
    Datum({
        required this.fact,
        required this.length,
    });

    String fact;
    int length;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fact: json["fact"],
        length: json["length"],
    );

    Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
    };
}

