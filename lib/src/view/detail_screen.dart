import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:practica5_api/src/models/pokimon_model.dart';
import 'package:practica5_api/src/network/api_pokimon.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  ApiPokimon? apiPokimon;

  @override
  void initState() {
    super.initState();
    apiPokimon = ApiPokimon();
  }

  @override
  Widget build(BuildContext context) {

    final pokimon = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      body: FutureBuilder(
        future: apiPokimon!.get(pokimon['id'].toString()),
        builder: (BuildContext context, AsyncSnapshot<PokimonModel?> snapshot){
          if (snapshot.hasError) {
            return Center(child: Text('Hay error en la peticion'),);
          }else{
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(children:[
                Image.asset(
                  "assets/pokebol3.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  colorBlendMode: BlendMode.modulate
                ),
                _detallePokimon(snapshot.data)
                ]);
            }else{
              return CircularProgressIndicator();
            }
          }
        }
      ),
    );
  }

  Widget xd(String url, String gen) {
    return Container(
      height: 200,
      width: 300,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 2, color: Colors.green)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image(image: NetworkImage("$url"),fit: BoxFit.fitHeight, colorBlendMode: BlendMode.modulate,height: 130,),
            Text(gen)
          ]
        ),
      ),
      decoration: BoxDecoration(
        /*boxShadow: [
          BoxShadow(
            color: Colors.white54,
            blurRadius: 5.0,
            offset: Offset(0, 10),
            spreadRadius: 0.5,
          ),
        ],*/
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _detallePokimon(PokimonModel? pokimeme){

    final pokimon = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    PokimonModel pkmn = pokimeme!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(pkmn.name![0].toUpperCase()+pkmn.name!.substring(1)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
            children: [
              CarouselSlider(
                items: [
                  xd("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/gray/${pkmn.id}.png","Gen. 1"),
                  xd("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/${pkmn.id}.png","Gen. 2"),
                  xd("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/${pkmn.id}.png","Gen. 3"),
                  xd("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/${pkmn.id}.png","Gen. 4"),
                  xd("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/${pkmn.id}.gif","Gen. 5"),

                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
              ),
              SizedBox(height: 135,),
              Text('Entrada en Pokédex: ${pkmn.id}', style: TextStyle(fontSize: 20,),),
              SizedBox(height: 10,),
              Text('Nombre: ${pkmn.name![0].toUpperCase()+pkmn.name!.substring(1)}', style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('Peso: ${(pkmn.weight)!/10}kg', style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('Altura: ${(pkmn.height)!/10}m', style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Text('Experiencia base: ${pkmn.base_experience}', style: TextStyle(fontSize: 20),),
            ],
        ),
      ),
    );
  }
}