import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'skill_model.g.dart';

@JsonSerializable()
class SkillModel extends Equatable {
  final int id;
  final String name;
  final String? category;
  final DateTime createdAt;

  const SkillModel({
    required this.id,
    required this.name,
    this.category,
    required this.createdAt,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

  @override
  List<Object?> get props => [id, name, category, createdAt];

  SkillModel copyWith({
    int? id,
    String? name,
    String? category,
    DateTime? createdAt,
  }) {
    return SkillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static SkillModel mock() {
    return SkillModel(
      id: 1,
      name: 'Flutter',
      category: 'programming',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );
  }
}

@JsonSerializable()
class UserSkillModel extends Equatable {
  final int id;
  final int userId;
  final int skillId;
  final String proficiencyLevel;
  final int yearsOfExperience;
  final DateTime createdAt;
  final SkillModel? skill;

  const UserSkillModel({
    required this.id,
    required this.userId,
    required this.skillId,
    required this.proficiencyLevel,
    required this.yearsOfExperience,
    required this.createdAt,
    this.skill,
  });

  factory UserSkillModel.fromJson(Map<String, dynamic> json) =>
      _$UserSkillModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSkillModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        skillId,
        proficiencyLevel,
        yearsOfExperience,
        createdAt,
        skill,
      ];

  UserSkillModel copyWith({
    int? id,
    int? userId,
    int? skillId,
    String? proficiencyLevel,
    int? yearsOfExperience,
    DateTime? createdAt,
    SkillModel? skill,
  }) {
    return UserSkillModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      skillId: skillId ?? this.skillId,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      createdAt: createdAt ?? this.createdAt,
      skill: skill ?? this.skill,
    );
  }

  static UserSkillModel mock() {
    return UserSkillModel(
      id: 1,
      userId: 1,
      skillId: 1,
      proficiencyLevel: 'advanced',
      yearsOfExperience: 3,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      skill: SkillModel.mock(),
    );
  }
}

enum ProficiencyLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

extension ProficiencyLevelExtension on ProficiencyLevel {
  String get displayName {
    switch (this) {
      case ProficiencyLevel.beginner:
        return 'Beginner';
      case ProficiencyLevel.intermediate:
        return 'Intermediate';
      case ProficiencyLevel.advanced:
        return 'Advanced';
      case ProficiencyLevel.expert:
        return 'Expert';
    }
  }

  String get value {
    return name;
  }

  static ProficiencyLevel fromString(String value) {
    return ProficiencyLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ProficiencyLevel.intermediate,
    );
  }
}
