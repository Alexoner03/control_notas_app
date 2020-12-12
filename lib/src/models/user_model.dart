class Users {

  List<User> usuarios = new List();

  Users.fromJsonList(List<dynamic> jsonlist){
    if(jsonlist == null) return;

    jsonlist.forEach((element) {
      final user = User.fromJson(element);
      usuarios.add(user);
    });
  }

  Users.fromJsonCourseList(List<dynamic> jsonlist){
    if(jsonlist == null) return;

    jsonlist.forEach((element) {
      final user = User.fromJsonStudents(element);
      usuarios.add(user);
    });
  }

}

class User {
    User({
        this.id,
        this.email,
        this.nombres,
        this.apellidos,
        this.state,
        this.createdAt,
        this.codigo,
        this.roleId,
        this.role,
        this.idByRol,
        this.nota
    });

    int id;
    String email;
    String nombres;
    String apellidos;
    int state;
    DateTime createdAt;
    String codigo;
    int roleId;
    String role;
    int idByRol;
    int nota;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
        codigo : json["student"] == null ? json["teacher"]["codigo"] : json["student"]["codigo"],
        idByRol : json["student"] == null ? json["teacher"]["id"] : json["student"]["id"],
        roleId : json["role"]["id"],
        role : json["role"]["descripcion"]
    );

    factory User.fromJsonStudents(Map<String, dynamic> json) => User(
        id: json["user_id"],
        email: json["user"]["email"],
        nombres: json["user"]["nombres"],
        apellidos: json["user"]["apellidos"],
        state: json["user"]["state"],
        createdAt: DateTime.parse(json["created_at"]),
        codigo : json["codigo"],
        idByRol : json["id"],
        roleId : json["user"]["role"]["id"],
        role : json["user"]["role"]["descripcion"],
        nota : json["pivot"]["nota"] == null ? 0 : json["pivot"]["nota"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombres": nombres,
        "apellidos": apellidos,
        "state": state,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "codigo": codigo,
        "role_id": roleId,
        "role": role,
        "id_by_rol" : idByRol
    };
}