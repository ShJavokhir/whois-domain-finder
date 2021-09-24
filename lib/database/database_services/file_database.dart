import 'dart:io';

import 'package:cli/database/domain_repository.dart';
import 'package:cli/logger/logger.dart';

class FileDatabase implements DomainRepository {
  late final File _localFile;

  FileDatabase({required File localFile}) {
    _localFile = localFile;
  }

  @override
  Future<void> addDomain(String domainName) async {
    final domains = await getDomains();
    try{
      if(!domains.contains(domainName))
        await _localFile.writeAsString('$domainName\n', mode:FileMode.append);
    }catch(e){
      Logger.logError(e.toString());
      /*if(e.toString().contains('Cannot open file')){
        //FileMode.append does not work when file were not created, so we gonna create file and write it here without FileMode.append
        await _localFile.writeAsString('$domainName\n');
      }*/
    }

  }

  @override
  Future<void> deleteDomain(String domainName) async{
    final domains = await getDomains();
    domains.remove(domainName);
    String finalDomains='';
    domains.forEach((element) {
      finalDomains = '$element\n';
    });
    await _localFile.writeAsString(finalDomains);
  }

  @override
  Future<List<String>> getDomains() async {
    try{
      return await _localFile.readAsLines();
    }catch(e){
      Logger.logError(e.toString());
    }
    return [];
  }
}
