import 'package:bridge/bridge.dart';
import 'package:bridge/clients/webclient.dart';

void main() {
  final Client client = WebCLient( domain: "example.com");

  final Request req = Request.getNoBody(path: "", queryParameters: {});
  client.make(req).then((ResponseInterface res) {
    print(res.statusCode);
    print(res.errorMessage );
    print(res.body.content);
  });


  
  
}
