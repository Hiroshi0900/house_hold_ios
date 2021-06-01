class User {
  String gender;
  String email;
  Name name;
  Picture picture;

  User({this.gender, this.email, this.name});

  User.fromJson(Map json) {
    gender = json['gender'];
    email = json['email'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({
    this.title,
    this.first,
    this.last,
  });
  Name.fromJson(Map json) {
    title = json['title'];
    title = json['first'];
    title = json['last'];
  }
  Map toJson() {
    final Map data = new Map();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
  }
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({this.large, this.medium, this.thumbnail});
  Picture.fromJson(Map json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }
  Map toJson() {
    final Map data = new Map();
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['thumbnail'] = this.thumbnail;
  }
}
