// Base Model áp dụng OOP principles
abstract class BaseModel<T> {
  String get id;
  
  // Abstract methods that must be implemented
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
  T copyWith();
  
  // Common validation method
  bool isValid();
  
  // Comparison methods
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseModel && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

// Interface for entities that can be searched
abstract class Searchable {
  bool matchesSearchQuery(String query);
}

// Interface for entities with status
abstract class StatusTrackable {
  bool get isActive;
  DateTime get lastModified;
}
