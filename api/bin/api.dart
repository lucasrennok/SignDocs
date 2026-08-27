import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../lib/routes/routes.dart';

void main() async {
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    8080,
  );

  server.autoCompress = true;

  print(
    "Servidor iniciado em http://${server.address.host}:${server.port}",
  );
}