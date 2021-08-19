import 'package:cli/domain_finder.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  var dio = Dio();
  var domainFinder = DomainFinder(
      serviceName: 'CCTLD_UZ', domainZone: 'uz', length: 3, dio: dio);
  domainFinder.startSearch();
}
