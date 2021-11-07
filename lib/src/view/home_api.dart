import 'package:flutter/material.dart';
import 'package:practica5_api/src/models/pokimons_model.dart';
import 'package:practica5_api/src/network/api_pokimons.dart';

class HomeApi extends StatefulWidget {
  HomeApi({Key? key}) : super(key: key);

  @override
  _HomeApiState createState() => _HomeApiState();
}

class _HomeApiState extends State<HomeApi> {

  ApiPokimons? apiPokimons;

  @override
  void initState() {
    super.initState();
    apiPokimons = ApiPokimons();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Image.asset(
          "assets/pokebol3.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitHeight,
          color: const Color.fromRGBO(255, 255, 255, 0.5),
          colorBlendMode: BlendMode.modulate
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Pokédex'),
          ),
          body: FutureBuilder(
            future: apiPokimons!.getAll(),
            builder: (BuildContext context, AsyncSnapshot<List<PokimonsModel>?> snapshot){
              if (snapshot.hasError) {
                return Center(child: Text('Hay error en la peticion'),);
              }else{
                if (snapshot.connectionState == ConnectionState.done) {
                  return _listPokemons(snapshot.data);
                }else{
                  return CircularProgressIndicator();
                }
              }
            }
          ),
        ),
      ]
    );
  }

  Widget _listPokemons(List<PokimonsModel>? movies){
    return ListView.separated(
      itemBuilder: (context,index){
        PokimonsModel pokimon = movies![index];
        return Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10, height: 10,),
                        Text(
                          pokimon.name![0].toUpperCase()+pokimon.name!.substring(1),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10, height: 10,),
                          Text(
                            'Pokédex: ${index+1}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(right: 60,left: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red,),
                        onPressed: (){
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: {
                              'id' : (index+1),
                              'name' : pokimon.name
                            }
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.catching_pokemon,),
                            //Text('Ver detalles...')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png'),
                  backgroundColor: Colors.green[100],
                  radius: 45,
                )
              ],
            ),
          ),
        );
      }, 
      separatorBuilder: (_,__) => Divider(height: 10,), 
      itemCount: movies!.length
    );
  }
}