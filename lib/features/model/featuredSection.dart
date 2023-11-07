class Featured {
  String? original;
  String? name;
  String? discount;

  Featured({this.original, this.name, this.discount});

  Featured.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    name = json['name'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['name'] = this.name;
    data['discount'] = this.discount;
    return data;
  }
}

class Category {
  String? name;

  Category({this.name});
}
