class PokimonModel {
  int? base_experience;
  int? height;
  int? id;
  String? name;
  int? weight;

  PokimonModel({
    this.base_experience,
    this.height,
    this.id,
    this.name,
    this.weight,
  });

  factory PokimonModel.fromMap(Map<String,dynamic> map){
    return PokimonModel(
      base_experience   : map['base_experience'],
      height   : map['height'],
      id   : map['id'],
      name  : map['name'],
      weight  : map['weight'],
    );
  }

  PokimonModel.fromJson(Map<String,dynamic> json){
    this.base_experience = json['base_experience'];
    this.height = json['height'];
    this.id = json['id'];
    this.name = json['name'];
    this.weight = json['weight'];
  }
}