class Property {
  String name;
  String size;
  String propertyType;

  Property({
    required this.name,
    required this.size,
    required this.propertyType,
  });

  Map<String, Object> toJson() {
    return {
      'name': name,
      'size': size,
      'property type': propertyType,
    };
  }

  static Property fromJson(Map<String, dynamic> jsonProperty) {
    return Property(
      name: jsonProperty['name'] as String,
      size: jsonProperty['size'] as String,
      propertyType: jsonProperty['property type'] as String,
    );
  }
}
