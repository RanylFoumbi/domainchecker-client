import 'dart:convert';
import 'package:domainavailability/config/config.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  Future fetchDomains(String domain) async {
    var results = await http
        .post((ROOT_URL + "api/v1/fetch-domains"), body: {'domain': domain});
    Iterable domainList = jsonDecode(results.body)['data']['domains'];
    print(jsonDecode(results.body)['data']['domains'][1]['isDead']);
    print(jsonDecode(results.body)['data']['domains'][1]['isDead'].runtimeType);
    return domainList;
  }
}
