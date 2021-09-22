import 'dart:convert';

import 'package:cli/whois_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

class ESKIZ_UZ implements WhoisService {
  static const postURL = "https://my.eskiz.uz/get/whois";
  String URL = "";
  Response? response;
  Dio? dio;
  String? domainName;
  String? domainZone;

  ESKIZ_UZ(Dio dio) {
    this.dio = dio;
  }
  @override
  void setDomain(String domainName, String domainZone) {
    //URL = 'https://cctld.uz/whois/?domain=${domainName}&zone=${domainZone}';
    this.domainName = domainName;
    this.domainZone = domainZone;
    //print(URL);
  }

  //this function just calls whois service and receive response.
  @override
  Future<void> callService() async {
    //This line of code prevents server of thinking request from bot or crawler.
    makeClientReliable();
    var params = {
      "domain": '${domainName}.${domainZone}',
      "whois": "true",
    };
    response = await dio?.post(postURL, data: jsonEncode(params));
  }

  @override
  bool isEmpty() {
    final data = response?.data;
    //we assume that website's language is russian
    if (data.toString().contains('не найден') ||
        data.toString().contains('Redemption')) {
      return true;
    } else {
      return false;
    }
  }

  void makeClientReliable() {
    dio?.options.headers['User-Agent'] =
        'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';
    dio?.options.headers['Accept'] =
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp'
        '';
  }
}
