import 'package:dio/dio.dart';
import 'package:path/path.dart';

const bool isDevelopment = true;
const String API_HOST =
    isDevelopment ? "http://192.168.1.177/ebilling" : "http://localhost";
const String API_KEY = "A6512FAF9A56402D4C5E3CC2AE97C803";
BaseOptions _options = new BaseOptions(
  connectTimeout: 30000,
  receiveTimeout: 30000,
);
Dio _dio = new Dio(_options);

class API {
  String token = "";

  Future<void> postData(
      {required String url,
      Map<String, String>? header,
      required Map<String, dynamic> data,
      onComplete(String data, int statusCode)?,
      onError(DioError error)?,
      onSendProgress(int sent, int total)?,
      onReceiveProgress(int receive, int total)?}) async {
    if (header == null) header = {};
    if (data == null) data = {};
    header.addAll({"X-Api-Key": API_KEY, "X-Token": API_KEY});
    // print("POST\nURL : $url \nBODY : $data");
    try {
      FormData formData = new FormData.fromMap(data);
      Response response = await _dio.post(url,
          data: formData,
          options: Options(headers: header, responseType: ResponseType.plain),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      onComplete!(response.data, response.statusCode!);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // print(e.response!.data);
        onComplete!(e.response!.data, e.response!.statusCode!);
      }
      if (onError != null) onError(e);
      // print(e);
    }
  }

  Future<void> getData({
    required String url,
    Map<String, String>? header,
    Map<String, String>? params,
    onComplete(String data, int statusCode)?,
    onError(DioError error)?,
  }) async {
    if (header == null) header = {};
    header.addAll({"X-Api-Key": API_KEY, "X-Token": token});
    print("GET\nURL : $url \nPARAMS : $params");
    try {
      Response response = await _dio.get(url,
          queryParameters: params,
          options: Options(headers: header, responseType: ResponseType.plain));
      onComplete!(
        response.data,
        response.statusCode!,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print(e.response!.data);
      }
      if (onError != null) onError(e);
    }
  }

  Future<void> uploadFile(
      {required String url,
      required Map<String, String> file, //fieldbody : pathfile
      Map<String, String>? header,
      required Map<String, dynamic> data,
      onComplete(String data, int statusCode)?,
      onError(DioError error)?,
      onSendProgress(int send, int total)?,
      onReceiveProgress(int receive, int total)?}) async {
    if (header == null) header = {};
    header.addAll({"X-Api-Key": API_KEY, "X-Token": token});
    FormData formData = FormData.fromMap(data);
    if (file != null) {
      file.forEach((key, value) async {
        formData.files.add(MapEntry(key,
            await MultipartFile.fromFile(value, filename: basename(value))));
      });
    }
    // });
    try {
      Response response = await _dio.post(url,
          data: formData,
          options: Options(headers: header, responseType: ResponseType.plain),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      onComplete!(response.data, response.statusCode!);
    } on DioError catch (e) {
      if (onError != null) onError(e);
    }
  }
}

class UrlApi {
  String login = API_HOST + "/api/user/login";
}
