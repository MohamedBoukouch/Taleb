class HomeModel {
  int? id;
  String? localisation;
  String? type;
  String? date;
  String? titel;
  String? description;
  String? file;
  int? numberlike;
  int? numbercomment;
  String? link;
  int? favorite;
  int? liked;

  HomeModel(
      {this.id,
      this.localisation,
      this.type,
      this.date,
      this.titel,
      this.description,
      this.file,
      this.numberlike,
      this.numbercomment,
      this.link,
      this.favorite,
      this.liked});

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localisation = json['localisation'];
    type = json['type'];
    date = json['date'];
    titel = json['titel'];
    description = json['description'];
    file = json['file'];
    numberlike = json['numberlike'];
    numbercomment = json['numbercomment'];
    link = json['link'];
    favorite = json['favorite'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['localisation'] = this.localisation;
    data['type'] = this.type;
    data['date'] = this.date;
    data['titel'] = this.titel;
    data['description'] = this.description;
    data['file'] = this.file;
    data['numberlike'] = this.numberlike;
    data['numbercomment'] = this.numbercomment;
    data['link'] = this.link;
    data['favorite'] = this.favorite;
    data['liked'] = this.liked;
    return data;
  }
}
