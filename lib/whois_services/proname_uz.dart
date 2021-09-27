///this domain service only returns whether domain inactive or actice
import 'dart:convert';

import 'package:cli/enums/domain_status_enum.dart';
import 'package:cli/models/domain_status_with_info.dart';
import 'package:cli/whois_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

class PRONAME_UZ implements WhoisService {
  static const postURL = "https://proname.uz/check";
  String URL = "";
  Response? response;
  Dio? dio;
  String? domainName;
  String? domainZone;

  PRONAME_UZ(Dio dio) {
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

    response = await dio?.get('$postURL//?domains=$domainName');
  }

  @override
  DomainStatusWithInfo getDomainStatus() {
    final data = response?.data.toString();
    //we assume that website's language is russian
    if (data.toString().contains('2')) {
      return DomainStatusWithInfo(
          domainStatus: DomainStatus.EXPIRED, info: "Free to buy");
    }

    return DomainStatusWithInfo(
        domainStatus: DomainStatus.ACTIVE, info: "Domain is Active ;(");
  }

  void makeClientReliable() {
    dio?.options.headers['User-Agent'] =
        'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';
    dio?.options.headers['Accept'] =
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp'
        '';
    dio?.options.headers['X-Requested-With'] = 'XMLHttpRequest';
  }
}
