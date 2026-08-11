import 'package:api/api.dart' as api;

import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) => Response.ok('Ok, working.\n');
Response _echoHandler(Request req) {
  final message = req.params['message'];
  return Response.ok('$message\n');
}


void main() async {
  final ip = InternetAddress.anyIPv4 ?? '0.0.0.0';

  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await shelf_io.serve(handler, ip, port);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}