import 'dart:convert';


class Courses {

  List<Course> cursos = new List();

  Courses.fromJsonList(List<dynamic> jsonlist){
    if(jsonlist == null) return;

    jsonlist.forEach((element) {
      final curso = Course.fromJson(element);
      cursos.add(curso);
    });
  }

  Courses.fromJsonListStudent(List<dynamic> jsonlist){
    if(jsonlist == null) return;

    print(jsonlist);

    jsonlist.forEach((element) {
      print(element);
      final curso = Course.fromJsonStudent(element);
      cursos.add(curso);
    });
  }

}

class Course {
    Course({
        this.id,
        this.nombre,
        this.inicio,
        this.fin,
        this.teacherId,
        this.state,
        this.createdAt,
        this.nota,
        this.teacher
    });

    int id;
    String nombre;
    DateTime inicio;
    DateTime fin;
    int teacherId;
    int state;
    DateTime createdAt;
    int nota;
    String teacher;


    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        nombre: json["nombre"],
        inicio: DateTime.parse(json["inicio"]),
        fin: DateTime.parse(json["fin"]),
        teacherId: json["teacher_id"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    factory Course.fromJsonStudent(Map<String, dynamic> json) => Course(
        id: json["id"],
        nombre: json["nombre"],
        inicio: DateTime.parse(json["inicio"]),
        fin: DateTime.parse(json["fin"]),
        teacherId: json["teacher_id"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
        nota : json["pivot"]["nota"] == null ? -1 : json["pivot"]["nota"],
        teacher: "${json["teacher"]["user"]["nombres"]} ${json["teacher"]["user"]["apellidos"]}"
    );


    Map<String, dynamic> toJson() => {
        "Curso": nombre,
        "Inicio": "${inicio.year.toString().padLeft(4, '0')}-${inicio.month.toString().padLeft(2, '0')}-${inicio.day.toString().padLeft(2, '0')}",
        "Fin": "${fin.year.toString().padLeft(4, '0')}-${fin.month.toString().padLeft(2, '0')}-${fin.day.toString().padLeft(2, '0')}",
        "Nota" : nota == -1 ? "PENDIENTE" : nota,
        "Docente": teacher
    };
}