abstract class DomainRepository {
  Future<void> addDomain(String domainName);
  Future<List<String>> getDomains();
  Future<void> deleteDomain(String domainName);
}
