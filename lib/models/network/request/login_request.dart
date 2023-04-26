class LoginRequestBody {
	String? username;
	String? password;

	LoginRequestBody({this.username, this.password});

	LoginRequestBody.fromJson(Map<String, dynamic> json) {
		username = json['user_name'];
		password = json['pass_word'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if(this.username != null){
			data['user_name'] = this.username;
		}
		if(this.password != null){
			data['pass_word'] = this.password;
		}
		return data;
	}
}
