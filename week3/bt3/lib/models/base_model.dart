// Base Model - OOP với tính trừu tượng
abstract class BaseModel<T> {
  String get id;
  
  // Abstract methods
  T copyWith();
  bool isValid();
  
  @override
  bool operator ==(Object other) => 
      other is BaseModel && other.id == id;
  
  @override
  int get hashCode => id.hashCode;
}

// Interface cho việc tìm kiếm
abstract class Searchable {
  bool matchesSearchQuery(String query);
}
