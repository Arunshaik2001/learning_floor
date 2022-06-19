import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final String description;

  Note(this.id, this.title,this.description);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, message: $title, description: $description}';
  }

  Note copyWith({
    int? id,
    String? message,
    String? description,
  }) {
    return Note(
      id ?? this.id,
      message ?? this.title,
      description ?? this.description,
    );
  }
}
