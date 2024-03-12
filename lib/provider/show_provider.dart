import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trogen/model/show_model.dart' as Model;

class ShowProvider extends ChangeNotifier {
  List<Model.ShowModel> _shows = [];
  List<dynamic> _actors = [];

  List<Model.ShowModel> get shows => _shows;
  List<dynamic> get actors => _actors;

  Future<void> fetchShows() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.tvmaze.com/shows'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _shows = data.map((json) => Model.ShowModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load shows');
      }
    } catch (e) {
      print('Error fetching shows: $e');
    }
  }

  Future<void> fetchActors(String showId) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.tvmaze.com/shows/$showId/cast'));
      if (response.statusCode == 200) {
        _actors = jsonDecode(response.body);
        notifyListeners();
      } else {
        throw Exception('Failed to load actors');
      }
    } catch (e) {
      print('Error fetching actors: $e');
    }
  }
}
