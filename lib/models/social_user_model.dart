class SocialUserModel{

  String? name;
  String? email;
  String? phone;
  String? uId;
  String? cover;
  String? image;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.cover,
    this.image,
    this.bio,
    this.isEmailVerified
  });

  SocialUserModel.fromjson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'cover':cover,
      'image':image,
      'bio':bio,
      'isEmailVerified':isEmailVerified
    };
  }


}