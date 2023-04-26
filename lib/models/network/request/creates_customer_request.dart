class CreatesCustomerRequestBody {
   String? phoneNumber;
   String? fullName;
   String? birthday;
   int? sex;
   String? address;
   String? email;
   String? avatar;
   String? idCustomer;


  CreatesCustomerRequestBody({this.phoneNumber, this.fullName, this.birthday,
      this.sex, this.address,this.email, this.avatar,this.idCustomer});

  CreatesCustomerRequestBody.fromJson(Map<String?, dynamic> json) {
    phoneNumber = json['dien_thoai'];
    fullName = json['ten_kh'];
    birthday = json['ngay_sinh'];
    sex = json['sex'];
    address = json['dia_chi'];
    idCustomer = json['ma_kh'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if(this.phoneNumber != null){
      data['dien_thoai'] = this.phoneNumber;
    }
    if(this.fullName != null){
      data['ten_kh'] = this.fullName;
    }
    if(this.birthday != null){
      data['ngay_sinh'] = this.birthday;
    }
    if(this.sex != null){
      data['sex'] = this.sex;
    }
    if(this.address != null){
      data['dia_chi'] = this.address;
    }
    if(this.idCustomer != null){
      data['ma_kh'] = this.idCustomer;
    }
    if(this.email != null){
      data['email'] = this.email;
    }
    if(this.avatar != null){
      data['avatar'] = this.avatar;
    }
    return data;
  }
}
