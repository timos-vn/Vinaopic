import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/creates_customer_request.dart';
import 'package:vinaoptic/models/network/request/creates_make_appointment_request.dart';
import 'package:vinaoptic/models/network/request/get_all_customer_request.dart';
import 'package:vinaoptic/models/network/request/get_customer_history.dart';
import 'package:vinaoptic/models/network/request/get_list_awaiting_request.dart';
import 'package:vinaoptic/models/network/request/get_list_detail_customer_request.dart';
import 'package:vinaoptic/models/network/request/get_list_doctor_request.dart';
import 'package:vinaoptic/models/network/request/get_list_lich_hen_request.dart';
import 'package:vinaoptic/models/network/request/get_list_order_request.dart';
import 'package:vinaoptic/models/network/request/login_request.dart';
import 'package:vinaoptic/models/network/request/order_history_request.dart';
import 'package:vinaoptic/models/network/request/search_product_request.dart';
import 'package:vinaoptic/models/network/request/send_invoice_request.dart';
import 'package:vinaoptic/models/network/request/sign_up_request.dart';
import 'package:vinaoptic/models/network/request/update_order_request.dart';
import '../../../core/untils/log.dart';
import 'host.dart';

class NetWorkFactory {
  BuildContext context;
  Dio? _dio;
  bool? isGoogle;
  String? refToken;
  String? token;

  // constructor
  NetWorkFactory(this.context) {
    HostSingleton hostSingleton = HostSingleton();
    hostSingleton.showError();
    String host = hostSingleton.host;
    int port = hostSingleton.port;
    if (!host.contains("http")) {
      host = "http://" + host;
      print('Check host=> ' + host);
    }
    print('test connection');
    print("$host:$port");
    _dio = Dio(BaseOptions(
      baseUrl: "$host:$port",
      receiveTimeout: 10000,
      connectTimeout: 10000,
    ));
    _setupLoggingInterceptor();
  }

  void _setupLoggingInterceptor(){
    int maxCharactersPerLine = 200;
    refToken = Const.REFRESH_TOKEN;
    _dio!.interceptors.clear();
    _dio!.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options, handler){
          logger.d("--> ${options.method} ${options.path}");
          logger.d("Content type: ${options.contentType}");
          logger.d("Request body: ${options.data}");
          logger.d("<-- END HTTP");
          return handler.next(options);
        },
        onResponse: (Response response, handler) {
          // Do something with response data
          logger.d("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            int iterations = (responseAsString.length / maxCharactersPerLine).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
            }
          } else {
            logger.d(response.data);
          }
          logger.d("<-- END HTTP");
          return handler.next(response); // continue
        },
        onError: (DioError error,handler) async{
          // Do something with response error
          logger.e("DioError: ${error.message}");
          if(error.type == DioErrorType.connectTimeout){
            Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Đường truyền mạng không ổn định');
          }
          if (error.response?.statusCode == 402) {
            try {
              await _dio!.post(
                  "https://refresh.api",
                  data: jsonEncode(
                      {"refresh_token": refToken}))
                  .then((value) async {
                if (value.statusCode == 201) {
                  //get new tokens ...
                  //set bearer
                  error.requestOptions.headers["Authorization"] =
                      "Bearer " + token!;
                  //create request with new access token
                  final opts = Options(
                      method: error.requestOptions.method,
                      headers: error.requestOptions.headers);
                  final cloneReq = await _dio!.request(error.requestOptions.path,
                      options: opts,
                      data: error.requestOptions.data,
                      queryParameters: error.requestOptions.queryParameters);

                  return handler.resolve(cloneReq);
                }
                return handler.next(error);
              });
              return handler.next(error);
            } catch (e) {
              logger.e(e.toString());
            }
          }
          if (error.response?.statusCode == 401) {
            // Utils.showToast('Hết phiên làm việc');
            // libGetX.Get.offAll(LoginPage());
          }else if(error.response?.statusCode == 500){
            // ignore: use_build_context_synchronously
            Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Lỗi kết nối tới server');
          }
          return handler.next(error); //continue
        })
    );
  }

  Future<Object> requestApi(Future<Response> request) async {
    try {
      Response response = await request;
//      var data = json.decode(response.data);
      var data = response.data;
//      if (!data.toString().contains("status"))
//        return data;
      if (data["statusCode"] == 200 || data["status"] == 200 || data["status"] == "OK" || data["status_code"] == 200 )
        return data;
      else {
        if (data["statusCode"] == 423) {
          //showOverlay((context, t) => UpgradePopup(message: data["message"],));
        } else if (data["statusCode"] == 401) {
          try {
            // Authen authBloc =
            // BlocProvider.of<AuthenticationBloc>(context);
            // authBloc.add(LoggedOut());
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        return data["message"];
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return _handleError(error);
    }
  }

  String _handleError(dynamic error) {
    String errorDescription = "";
    logger.e(error?.toString());
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          errorDescription = 'Kiểm tra kết nối mạng của bạn';
          break;
        case DioErrorType.cancel:
          errorDescription = 'ErrorSWC';
          break;
        case DioErrorType.connectTimeout:
          errorDescription = 'Kiểm tra kết nối mạng của bạn';
          break;
        case DioErrorType.other:
          if(error.message.contains('No address associated with hostname')){
            errorDescription = 'Kiểm tra HostId của bạn';
          }else{
            errorDescription = error.message.toString();
          }
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = 'Kiểm tra kết nối mạng của bạn';
          break;
        case DioErrorType.response:
          var errorData = error.response?.data;
          String? message;
          int code;
          if (!Utils.isEmpty(errorData)) {
            if(errorData is String){
              message = 'Không tìm thấy địa chỉ host server';
              code = 404;
            } else{
              message = errorData["message"].toString();
              code = errorData["statusCode"];
            }
          } else {
            code = error.response!.statusCode!;
          }
          errorDescription = message ?? "ErrorCode" ': $code';
          if (code == 401) {
            try {
              //libGetX.Get.offAll(LoginPage());
              // MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
              // mainBloc.add(LogoutMainEvent());
            } catch (e) {
              debugPrint(e.toString());
            }
          } else if (code == 423) {
            try {
              // AuthenticationBloc authBloc =
              // BlocProvider.of<AuthenticationBloc>(context);
              // authBloc.add(ShowUpgradeDialogEvent(message ?? ""));
            } catch (e) {
              debugPrint(e.toString());
            }
            //showOverlay((context, t) => UpgradePopup(message: message ?? "",), duration: Duration.zero);
          }
          break;
        default:
          errorDescription = 'Có lỗi xảy ra.';
      }
    }
    else {
      errorDescription = 'Có lỗi xảy ra.';
    }
    return errorDescription;
  }

  /// List API
  Future<Object> getConnection() async {
    return await requestApi(_dio!.get('api/check-connect'));
  }

  Future<Object> login(LoginRequestBody request) async {
    return await requestApi(_dio!.post('/api/v1/accounts/signin', data: request.toJson()));
  }

  Future<Object> signUp(SignUpRequestBody request) async {
    return await requestApi(_dio!.post('/api/v1/accounts/RegisterAccountERP', data: request.toJson()));
  }

  Future<Object> getUnits(String token) async {
    return await requestApi(_dio!.get('/api/v1/accounts/units', options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> config(String token, String unitId) async {
    return await requestApi(_dio!.get('/api/v1/accounts/units/cached', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "unitId": unitId,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> configStore(String token, String storeId) async {
    return await requestApi(_dio!.get('/api/v1/accounts/stores/cached', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "storeId": storeId,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getListStore(String token, String storeId) async {
    return await requestApi(_dio!.get('/api/v1/accounts/stores', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "storeId": storeId,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getDetailAppointment(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/list-HDL-detail', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getDetailOrder(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-GetOrderListDetail', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> createsCustomer(CreatesCustomerRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/create-customer', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> createsMakeAppointment(CreatesMakeAppointmentRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/Create-HDL', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListAppointmentSchedule(GetListAppointmentScheduleRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/list-HDL', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getAllListCustomer(GetAllListCustomerRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/customer-all-list', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListAwaitingCustomer(GetListAwaitingCustomer request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/customer-wait-list', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> searchCustomer(SearchCustomerRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/search', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListHistory(OrderHistoryRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/list-HDL-History', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListOrder(OrderRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/GetHDLOrderList', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListDoctor(DoctorRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/doctor-list', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListDetailCustomer(ListDetailPromissoryNoteCustomerRequestBody request, String token) async {
    return await requestApi(_dio!.post('/api/v1/customers/customer-info-history', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getDetail(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getBanner(String token) async {
    return await requestApi(_dio!.get('/api/v1/orders/banner-advertise', options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }
  Future<Object> getDetailCQ(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-cq', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }
  Future<Object> getDetailNT(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-nt', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }
  Future<Object> getDetailAT(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-at', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }
  Future<Object> getDetailLK(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-lk', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getDetailOrderCustomer(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-buy', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }
  Future<Object> getDetailTV(String token, String sttRec) async {
    return await requestApi(_dio!.get('/api/v1/orders/HDL-ExamResults-tv', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "stt_rec": sttRec,
    })); //["Authorization"] = "Bearer " + token
  }
  Future<Object> scanCodeByShopUser(String token, String code) async {
    return await requestApi(_dio!.get('/api/v1/items/scan-item', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "item_id": code,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> searchProduct(SearchProductRequest request, String token) async {
    return await requestApi(_dio!.post('/api/v1/items/search-item', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }
  Future<Object> sendInvoices(SendInvoiceRequest request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/Create-HDL-Order', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }
  Future<Object> updateInvoice(UpdateOrderRequest request, String token) async {
    return await requestApi(_dio!.post('/api/v1/orders/Update-HDL-Order', options: Options(headers: {"Authorization": "Bearer $token"}), data: request.toJson()));
  }

  Future<Object> getListProvince(String token, String idProvince,String idDistrict, int pageIndex, int pageCount) async {
    return await requestApi(_dio!.get('/api/v1/orders/list-province', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "idProvince": idProvince,
      "idDistrict": idDistrict,
      "page_index": pageIndex,
      "page_count": pageCount,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getListTicket(String token, String dateFrom,String dateTo,String key,String status, int pageIndex, int pageCount) async {
    return await requestApi(_dio!.get('/api/v1/orders/search-list-ticket', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "dateFrom": dateFrom,
      "dateTo": dateTo,"key": key,"status": status,
      "page_index": pageIndex,
      "page_count": pageCount,
    })); //["Authorization"] = "Bearer " + token
  }
}
