import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActorGridView extends StatefulWidget {
  final String showId;

  const ActorGridView({super.key, required this.showId});

  @override
  _ActorGridViewState createState() => _ActorGridViewState();
}

class _ActorGridViewState extends State<ActorGridView> {
  late List<dynamic> _actors = [];

  @override
  void initState() {
    super.initState();
    _fetchActors();
  }

  Future<void> _fetchActors() async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/shows/${widget.showId}/cast'));
    if (response.statusCode == 200) {
      setState(() {
        _actors = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load actors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _actors.length,
      itemBuilder: (context, index) {
        final actor = _actors[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (actor['person'] != null && actor['person']['name'] != null)
              Card(
                child: Column(
                  children: [
                    Image.network(
                      actor['person']['image']['medium'],
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(actor['person']['name']),
                    if (actor['character'] != null &&
                        actor['character']['name'] != null)
                      Text('as ${actor['character']['name']}'),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
