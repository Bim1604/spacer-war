import 'dart:convert';

class CodeName {
  final String id;
  final String name;
  final dynamic value;
  CodeName({
    required this.id,
    required this.name,
    required this.value,
  });

  CodeName copyWith({
    String? id,
    String? name,
    dynamic value,
  }) {
    return CodeName(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
    };
  }

  factory CodeName.fromMap(Map<String, dynamic> map) {
    return CodeName(
      id: map['id'] as String,
      name: map['name'] as String,
      value: map['value'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeName.fromJson(String source) => CodeName.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CodeName(id: $id, name: $name, value: $value)';

  @override
  bool operator ==(covariant CodeName other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ value.hashCode;
}
