import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trogen/pages/show_details.dart';
import 'package:trogen/provider/show_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showProvider = Provider.of<ShowProvider>(context);
    showProvider.fetchShows(); // Fetch shows when the widget is built

    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
      ),
      body: Consumer<ShowProvider>(
        builder: (context, provider, _) {
          if (provider.shows.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: provider.shows.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final showItem = provider.shows[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetails(show: showItem),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, top: 3),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Displaying the image if available
                          if (showItem.image != null &&
                              showItem.image!.medium != null)
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.network(
                                  showItem.image!.medium!,
                                  fit: BoxFit.fill,
                                  height: 150, // Adjust height as needed
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            "${showItem.name}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Language :",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text("${showItem.language}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
