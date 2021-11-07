import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica5_api/src/models/pokimons_model.dart';

class ApiPokimons {
  
  //var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=990a15c48635b7539780bd51cbd3a351&language=es-MX&page=1');

  Future<List<PokimonsModel>?> getAll() async{
    var URL = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151&offset=0');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var pokimons = jsonDecode(response.body)['results'] as List;
      //debugPrint(response.body);
      List<PokimonsModel> listPokimons = pokimons.map((movie) => PokimonsModel.fromMap(movie)).toList();
      return listPokimons;
    }else{
      return null;
    }
  }
}