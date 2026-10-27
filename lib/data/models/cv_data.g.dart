// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CvData _$CvDataFromJson(Map<String, dynamic> json) => _CvData(
  profile: json['profile'] == null
      ? const Profile()
      : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  links:
      (json['links'] as List<dynamic>?)
          ?.map((e) => ContactLink.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContactLink>[],
  experience:
      (json['experience'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Experience>[],
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Education>[],
  skills:
      (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SkillGroup>[],
  projects:
      (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Project>[],
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Certification>[],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageSkill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LanguageSkill>[],
);

Map<String, dynamic> _$CvDataToJson(_CvData instance) => <String, dynamic>{
  'profile': instance.profile.toJson(),
  'links': instance.links.map((e) => e.toJson()).toList(),
  'experience': instance.experience.map((e) => e.toJson()).toList(),
  'education': instance.education.map((e) => e.toJson()).toList(),
  'skills': instance.skills.map((e) => e.toJson()).toList(),
  'projects': instance.projects.map((e) => e.toJson()).toList(),
  'certifications': instance.certifications.map((e) => e.toJson()).toList(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  name: json['name'] as String? ?? '',
  title:
      (json['title'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  summary:
      (json['summary'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  location: json['location'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'name': instance.name,
  'title': instance.title,
  'summary': instance.summary,
  'location': instance.location,
  'email': instance.email,
  'phone': instance.phone,
  'photoUrl': ?instance.photoUrl,
};

_ContactLink _$ContactLinkFromJson(Map<String, dynamic> json) => _ContactLink(
  id: json['id'] as String,
  label: json['label'] as String? ?? '',
  url: json['url'] as String? ?? '',
);

Map<String, dynamic> _$ContactLinkToJson(_ContactLink instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'url': instance.url,
    };

_Experience _$ExperienceFromJson(Map<String, dynamic> json) => _Experience(
  id: json['id'] as String,
  role:
      (json['role'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  company: json['company'] as String? ?? '',
  location: json['location'] as String? ?? '',
  start: json['start'] as String? ?? '',
  end: json['end'] as String?,
  description:
      (json['description'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$ExperienceToJson(_Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'company': instance.company,
      'location': instance.location,
      'start': instance.start,
      'end': ?instance.end,
      'description': instance.description,
    };

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  id: json['id'] as String,
  school: json['school'] as String? ?? '',
  degree:
      (json['degree'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  start: json['start'] as String? ?? '',
  end: json['end'] as String?,
  description:
      (json['description'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'id': instance.id,
      'school': instance.school,
      'degree': instance.degree,
      'start': instance.start,
      'end': ?instance.end,
      'description': instance.description,
    };

_SkillGroup _$SkillGroupFromJson(Map<String, dynamic> json) => _SkillGroup(
  id: json['id'] as String,
  category:
      (json['category'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  items:
      (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$SkillGroupToJson(_SkillGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'items': instance.items,
    };

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  description:
      (json['description'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  techStack:
      (json['techStack'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  url: json['url'] as String? ?? '',
  start: json['start'] as String? ?? '',
  end: json['end'] as String?,
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'techStack': instance.techStack,
  'url': instance.url,
  'start': instance.start,
  'end': ?instance.end,
};

_Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    _Certification(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      issuer: json['issuer'] as String? ?? '',
      year: json['year'] as String? ?? '',
    );

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuer': instance.issuer,
      'year': instance.year,
    };

_LanguageSkill _$LanguageSkillFromJson(Map<String, dynamic> json) =>
    _LanguageSkill(
      id: json['id'] as String,
      name:
          (json['name'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      proficiency:
          (json['proficiency'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
    );

Map<String, dynamic> _$LanguageSkillToJson(_LanguageSkill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'proficiency': instance.proficiency,
    };
