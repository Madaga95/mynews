import 'package:http/http.dart' as http;

const newUrl =
    "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=22745f2e71c24f5082c93ab037f37369";

class NewsApi {
  static Future getArticles() {
    return http.get(Uri.parse(newUrl));
  }
}
