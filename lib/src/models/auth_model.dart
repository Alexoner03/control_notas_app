import 'dart:convert';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
    AuthResponse({
        this.res,
        this.message,
        this.token,
    });

    bool res;
    String message;
    String token;

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        res: json["res"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "res": res,
        "message": message,
        "token": token,
    };
}
