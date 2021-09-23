/*
import 'package:cli/whois_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

class CCTLD_UZ implements WhoisService {
  String URL = "";
  Response? response;
  Dio? dio;

  CCTLD_UZ(Dio dio) {
    this.dio = dio;
  }
  @override
  void setDomain(String domainName, String domainZone) {
    URL = 'https://cctld.uz/whois/?domain=${domainName}&zone=${domainZone}';
    //print(URL);
  }

  //this function just calls whois service and receive response.
  @override
  Future<void> callService() async {
    //This line of code prevents server of thinking request from bot or crawler.
    makeClientReliable();
    response = await dio?.get(
      URL,
    );
  }

  @override
  bool isEmpty() {
    final data = response?.data;
    //we assume that website's language is russian
    if (data.toString().contains('не найден')) {
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
*/
