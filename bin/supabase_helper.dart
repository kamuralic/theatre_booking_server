import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

class SupabaseClientHelper {
  static SupabaseClient client = SupabaseClient(
      'https://biqvzpvabujhigaadwpf.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpcXZ6cHZhYnVqaGlnYWFkd3BmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTU4OTU3NzgsImV4cCI6MTk3MTQ3MTc3OH0.fK4jLTepM2STv-Stv2SOELQZd5Ard0tSfqxBxbQ4Fto');

  ///Shows methods
  static Future<Response> getShows() async {
    final response = await client.from('shows').select().execute();
    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createShow(Map<String, dynamic> body) async {
    final response = await client.from('shows').insert(body).execute();

    return Response.ok(jsonEncode(response.data),
        headers: {'Content-Type': 'application/json'});
  }

  //Seats methods
  static Future<Response> getSeats() async {
    final response = await client.from('seats').select().execute();
    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }

  //Performance methods
  static Future<Response> getPerformances() async {
    final response = await client.from('performances').select().execute();
    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }

  //Tickets method
  static Future<Response> getTickets() async {
    final response = await client.from('tickets').select().execute();
    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }

  //Create ticket
  static Future<Response> createTicket(Map<String, dynamic> body) async {
    final response = await client.from('tickets').insert([body]).execute();

// If Create operation fails
    if (response.error != null) {
      return Response.notFound(
          jsonEncode({
            'success': false,
            'data': response.error!.message,
          }),
          headers: {'Content-type': 'application/json'});
    }

    // Return the newly added data
    return Response.ok(
      jsonEncode({'success': true, 'data': response.data}),
      headers: {'Content-type': 'application/json'},
    );

    // return Response.ok(jsonEncode(response.data),
    //     headers: {'Content-Type': 'application/json'});
  }

  //Tickets by id
  static Future<Response> getTicketsById(int ticketId) async {
    final response =
        await client.from('tickets').select().match({'id': ticketId}).execute();
    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }

  //Ticket remove method
  static Future removeTicket(int id) async {
    client.from('tickets').delete().match({'id': id}).execute();
  }

  //Login method
  static Future<Response> login(
      {required String username, required String password}) async {
    final response = await client.from('users').select().execute();
    //var map = {'shows': response.data};

    var result = response.data;

    List<dynamic> users = result as List<dynamic>;
    var user = users.firstWhere(
        (element) =>
            element["username"] == username && element["password"] == password,
        orElse: (() => null));
    print('From superbase response ');
    print(Response.ok(jsonEncode(user),
        headers: {'Content-Type': 'application/json'}));
    return Response.ok(jsonEncode(user),
        headers: {'Content-Type': 'application/json'});
  }

  //get users
  static Future<Response> getUsers() async {
    final response = await client.from('users').select().execute();
    //var map = {'shows': response.data};

    var map = response.data;
    return Response.ok(jsonEncode(map),
        headers: {'Content-Type': 'application/json'});
  }
}
