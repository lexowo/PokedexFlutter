import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica5_api/src/models/pokimon_model.dart';

class ApiPokimon{
  
  //var URL = Uri.parse('https://pokeapi.co/api/v2/pokemon/bulbasaur');

  Future<PokimonModel?> get(String pkmn) async{
    //var URL = Uri.parse('https://pokeapi.co/api/v2/pokemon/bulbasaur');
    var URL = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pkmn');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var pokememe = jsonDecode(response.body)['types'] as List;
      Map<String, dynamic> pokemimiMAP = jsonDecode(response.body);
      var pokemimi = PokimonModel.fromJson(pokemimiMAP);
      return pokemimi;
    }else{
      return null;
    }
  }
}