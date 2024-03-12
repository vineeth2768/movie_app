import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trogen/model/show_model.dart' as Model;
import 'package:trogen/pages/actors_list.dart';
import 'package:trogen/provider/show_provider.dart';

class ShowDetails extends StatelessWidget {
  final Model.ShowModel show;

  const ShowDetails({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showProvider = Provider.of<ShowProvider>(context);
    showProvider.fetchActors(
        show.id.toString()); // Fetch actors when the widget is built

    return Scaffold(
      appBar: AppBar(
        title: Text("${show.name}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (show.image != null && show.image!.original != null)
                Image.network(
                  show.image!.original!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              Text(
                'Language: ${show.language}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Type: ${show.type}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Ratings: ${show.rating!.average}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Gener: ${show.genres.toString()}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Summary:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                show.summary?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                    'No summary available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Actors:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Consumer<ShowProvider>(
                builder: (context, provider, _) {
                  if (provider.actors.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ActorGridView(
                        showId: show.id.toString()); // Pass showId here
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
