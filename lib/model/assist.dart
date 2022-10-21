import 'dart:convert';

class Assist {
  int id;
  String name;
  String description;
  Assist({
    required this.id,
    required this.name,
    required this.description,
  });

  Assist copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Assist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Assist.fromMap(Map<String, dynamic> map) {
    return Assist(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assist.fromJson(String source) =>
      Assist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Assist(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Assist &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
