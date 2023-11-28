import 'package:flutter/material.dart';

import '../model/Movie_list.dart';

class MovieDetailPage extends StatefulWidget {
  final Results movieDetails;

  const MovieDetailPage(this.movieDetails, {super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          widget.movieDetails.originalTitle ?? '',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              "https://image.tmdb.org/t/p/w342${widget.movieDetails.posterPath}",
              fit: BoxFit.cover,
            ),
          ),
          // Movie details
          Positioned(
            bottom: 20,
            left: 50,
            right: 20,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              // Set the desired height as a fraction of the screen height
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.movieDetails.originalTitle ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox( height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vote count: ${widget.movieDetails.voteCount}',
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                          Text(
                            'Release Date: ${widget.movieDetails.releaseDate}',
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox( height: 15,),
                      Text(
                        '${widget.movieDetails.overview}',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
