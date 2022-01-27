final String tableEmails = 'emails';

class EmailFields {
  static final List<String> values = [id, email];

  static final String id = '_id';
  static final String email = 'email';
}

class Email {
  final int? id;
  final String email;

  const Email({
    this.id,
    required this.email,
  });

  Email copy({int? id, String? email}) =>
      Email(id: id ?? this.id, email: email ?? this.email);

  static Email fromJson(Map<String, Object?> json) => Email(
      id: json[EmailFields.id] as int?,
      email: json[EmailFields.email] as String);

  Map<String, Object?> toJson() => {
        EmailFields.id: id,
        EmailFields.email: email,
      };
}
