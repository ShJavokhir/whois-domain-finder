import 'package:cli/models/domain_status_with_info.dart';

abstract class WhoisService {
  Future<void> callService();
  DomainStatusWithInfo getDomainStatus();
  void setDomain(String domainName, String domainZone);
}
