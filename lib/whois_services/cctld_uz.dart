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

  setDomain(String domainName, String domainZone) {
    URL = 'https://cctld.uz/whois/?domain=${domainName}&zone=${domainZone}';
  }

  //this function just calls whois service and receive response.
  @override
  Future<void> callService() async {
    response = await dio?.get(URL);
  }

  @override
  bool isEmpty() {
    final data = response?.data;
    if (data.toString().contains('не найден')) {
      return false;
    } else {
      return true;
    }
  }
}
