class Cast {
  List<Casting> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final colaborador = Casting.fromJsonMap(item);
      if (colaborador.department == Department.ACTING) {
        actores.add(colaborador);
      }
    });
  }
}

class Casting {
  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  Department department;
  String job;

  Casting({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Casting.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getPhoto() {
    if (profilePath == null) {
      return 'http://www.animeomega.es/foro/styles/canvas/theme/images/no_avatar.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}

enum Department {
  ACTING,
  WRITING,
  CREW,
  VISUAL_EFFECTS,
  DIRECTING,
  PRODUCTION,
  COSTUME_MAKE_UP,
  ART,
  SOUND,
  CAMERA,
  EDITING,
  LIGHTING
}
