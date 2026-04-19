class AdminModel {
  final String? name;
  final String? email;
  final String? image;
  final String? uid;
  final double balance;

  AdminModel({this.name, this.email, this.image,this.uid, required this.balance});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(      
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      balance: json['balance'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'uid': uid,
    };
  }

  Map<String, dynamic> upUpdateData(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(name != null) data['name'] = name;
    if(image != null) data['image'] = image;
    return data;      
  }
}
