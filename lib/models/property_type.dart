class PropertyType {
  String name;
  String location;

  PropertyType({
    required this.name,
    required this.location,
  });

  Map<String, Object> toJson() {
    return {
      'name': name,
      'location': location,
    };
  }

  static PropertyType fromJson(Map<String, Object> jsonPropertyType) {
    return PropertyType(
      name: jsonPropertyType['name'] as String,
      location: jsonPropertyType['location'] as String,
    );
  }
}
