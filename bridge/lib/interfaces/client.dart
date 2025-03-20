import 'package:bridge/interfaces/request_interface.dart';
import 'package:bridge/interfaces/response_interface.dart';



// A client that can make requests. can be implemented by a web client or library client or any other client like stdio client
abstract interface class Client {
  Future<ResponseInterface> make(RequestInterface req);
}
