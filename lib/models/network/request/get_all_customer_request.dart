class GetAllListCustomerRequestBody {
  int? pageIndex;
  int? pageCount;


  GetAllListCustomerRequestBody({this.pageIndex, this.pageCount,});

  GetAllListCustomerRequestBody.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.pageIndex != null){
      data['page_index'] = this.pageIndex;
    }
    if(this.pageCount != null){
      data['page_count'] = this.pageCount;
    }
    return data;
  }
}
