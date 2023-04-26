class GetListAppointmentScheduleRequestBody {
  int? pageIndex;
  int? pageCount;
  String? units;
  int? userId;
  String? dateForm;
  String? dateTo;
  String? status;

  GetListAppointmentScheduleRequestBody({this.pageIndex, this.pageCount,this.units,this.userId,this.dateForm,this.dateTo,this.status});

  GetListAppointmentScheduleRequestBody.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    units = json['unit'];
    userId = json['user_id'];
    dateForm = json['datefrom'];dateTo = json['dateto'];status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.pageIndex != null){
      data['page_index'] = this.pageIndex;
    }
    if(this.pageCount != null){
      data['page_count'] = this.pageCount;
    }if(this.units != null){
      data['unit'] = this.units;
    }if(this.userId != null){
      data['user_id'] = this.userId;
    }
    if(this.dateForm != null){
      data['datefrom'] = this.dateForm;
    }if(this.dateTo != null){
      data['dateto'] = this.dateTo;
    }if(this.status != null){
      data['status'] = this.status;
    }
    return data;
  }
}
