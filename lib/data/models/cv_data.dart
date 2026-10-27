import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_text.dart';

part 'cv_data.freezed.dart';
part 'cv_data.g.dart';

/// Top-level keys of the CV document. Each edit writes exactly one of these,
/// so the enum name must match the JSON key in [CvData].
enum CvField {
  profile,
  links,
  experience,
  education,
  skills,
  projects,
  certifications,
  languages,
}

/// The whole CV, stored as a single Firestore document (`cv/main`):
/// one read per visitor, and list order is simply array order.
@freezed
abstract class CvData with _$CvData {
  const factory CvData({
    @Default(Profile()) Profile profile,
    @Default(<ContactLink>[]) List<ContactLink> links,
    @Default(<Experience>[]) List<Experience> experience,
    @Default(<Education>[]) List<Education> education,
    @Default(<SkillGroup>[]) List<SkillGroup> skills,
    @Default(<Project>[]) List<Project> projects,
    @Default(<Certification>[]) List<Certification> certifications,
    @Default(<LanguageSkill>[]) List<LanguageSkill> languages,
  }) = _CvData;

  factory CvData.fromJson(Map<String, dynamic> json) => _$CvDataFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    @Default('') String name,
    @Default(<String, String>{}) LText title,
    @Default(<String, String>{}) LText summary,
    @Default('') String location,
    @Default('') String email,
    @Default('') String phone,
    String? photoUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@freezed
abstract class ContactLink with _$ContactLink {
  const factory ContactLink({
    required String id,
    @Default('') String label,
    @Default('') String url,
  }) = _ContactLink;

  factory ContactLink.fromJson(Map<String, dynamic> json) =>
      _$ContactLinkFromJson(json);
}

/// Dates are `yyyy` or `yyyy-MM` strings; a null [end] means "Present".
@freezed
abstract class Experience with _$Experience {
  const factory Experience({
    required String id,
    @Default(<String, String>{}) LText role,
    @Default('') String company,
    @Default('') String location,
    @Default('') String start,
    String? end,
    @Default(<String, String>{}) LText description,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

@freezed
abstract class Education with _$Education {
  const factory Education({
    required String id,
    @Default('') String school,
    @Default(<String, String>{}) LText degree,
    @Default('') String start,
    String? end,
    @Default(<String, String>{}) LText description,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

/// A category of skills, e.g. "Frameworks: Laravel, Bootstrap 5".
@freezed
abstract class SkillGroup with _$SkillGroup {
  const factory SkillGroup({
    required String id,
    @Default(<String, String>{}) LText category,
    @Default(<String>[]) List<String> items,
  }) = _SkillGroup;

  factory SkillGroup.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupFromJson(json);
}

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    @Default('') String name,
    @Default(<String, String>{}) LText description,
    @Default(<String>[]) List<String> techStack,
    @Default('') String url,
    @Default('') String start,
    String? end,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

@freezed
abstract class Certification with _$Certification {
  const factory Certification({
    required String id,
    @Default('') String name,
    @Default('') String issuer,
    @Default('') String year,
  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}

@freezed
abstract class LanguageSkill with _$LanguageSkill {
  const factory LanguageSkill({
    required String id,
    @Default(<String, String>{}) LText name,
    @Default(<String, String>{}) LText proficiency,
  }) = _LanguageSkill;

  factory LanguageSkill.fromJson(Map<String, dynamic> json) =>
      _$LanguageSkillFromJson(json);
}
