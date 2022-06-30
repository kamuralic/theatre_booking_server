import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'supabase_helper.dart';

class Service {
  static Handler get handler {
    final router = Router();

    router.get('/shows', (Request request) async {
      return await SupabaseClientHelper.getShows();
    });

    router.post('/create-show', (Request request) async {
      Map<String, dynamic> body = jsonDecode(await request.readAsString());
      return SupabaseClientHelper.createShow(body);
    });

    router.get('/seats', (Request request) async {
      return await SupabaseClientHelper.getSeats();
    });
    router.get('/performances', (Request request) async {
      return await SupabaseClientHelper.getPerformances();
    });

    router.get('/tickets', (Request request) async {
      return await SupabaseClientHelper.getTickets();
    });

    router.post('/create-ticket', (Request request) async {
      Map<String, dynamic> body = jsonDecode(await request.readAsString());
      return SupabaseClientHelper.createTicket(body);
    });

    router.delete('/tickets/delete/<id>', (Request request, int id) async {
      return await SupabaseClientHelper.removeTicket(id);
    });

    router.get('/tickets/<id>', (Request request, int id) async {
      return await SupabaseClientHelper.getTicketsById(id);
    });

    router.post('/login', (Request request) async {
      Map<String, dynamic> body = jsonDecode(await request.readAsString());
      print('route call');
      print(body);

      return SupabaseClientHelper.login(
          username: body['username'], password: body['password']);
    });
    router.get('/users', (Request request) async {
      return await SupabaseClientHelper.getUsers();
    });

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('API not found');
    });

    return router;
  }
}
