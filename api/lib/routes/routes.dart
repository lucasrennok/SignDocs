import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) => Response.ok('Ok, working.\n');
Response _echoHandler(Request req) {
  final message = req.params['message'];
  return Response.ok('$message\n');
}