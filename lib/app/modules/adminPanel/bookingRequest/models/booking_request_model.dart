import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookingRequest {
  String name;
  String email;
  bool approved;
  String id;
  BookingRequest({
    required this.name,
    required this.email,
    required this.approved,
    required this.id,
  });

  BookingRequest copyWith({
    String? name,
    String? email,
    bool? approved,
    String? id,
  }) {
    return BookingRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      approved: approved ?? this.approved,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'approved': approved,
      'id': id,
    };
  }

  factory BookingRequest.fromMap(Map<String, dynamic> map) {
    return BookingRequest(
      name: map['name'] as String,
      email: map['email'] as String,
      approved: map['approved'] as bool,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequest.fromJson(String source) =>
      BookingRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingRequest(name: $name, email: $email, approved: $approved, id: $id)';
  }

  @override
  bool operator ==(covariant BookingRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.approved == approved &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ approved.hashCode ^ id.hashCode;
  }
}
