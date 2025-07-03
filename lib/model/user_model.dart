// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

List<UserList> userListFromJson(String str) => List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
    int id;
    String name;
    String company;
    String username;
    String email;
    String address;
    String zip;
    String state;
    String country;
    String phone;
    String photo;

    UserList({
        required this.id,
        required this.name,
        required this.company,
        required this.username,
        required this.email,
        required this.address,
        required this.zip,
        required this.state,
        required this.country,
        required this.phone,
        required this.photo,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        name: json["name"],
        company: json["company"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        zip: json["zip"],
        state: json["state"],
        country: json["country"],
        phone: json["phone"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company": company,
        "username": username,
        "email": email,
        "address": address,
        "zip": zip,
        "state": state,
        "country": country,
        "phone": phone,
        "photo": photo,
    };
}
