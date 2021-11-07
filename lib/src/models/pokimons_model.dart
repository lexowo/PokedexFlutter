class PokimonsModel {
  String? name;
  String? url;

  PokimonsModel({
    this.name,
    this.url,
  });

  factory PokimonsModel.fromMap(Map<String,dynamic> map){
    return PokimonsModel(
      name  : map['name'],
      url   : map['url']
    );
  }
}
