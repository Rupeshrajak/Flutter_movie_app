import 'package:flutter/material.dart';
import 'package:hrms/top_rated/model/top_rated_movie.dart';
import 'package:hrms/top_rated/widget/top_rated_movie_detail_page.dart';



class TopRatedMovieListItem extends StatefulWidget {
  final Results movieDetails;

  const TopRatedMovieListItem(this.movieDetails, {super.key});

  @override
  State<TopRatedMovieListItem> createState() => _TopRatedMovieListItemState();
}

class _TopRatedMovieListItemState extends State<TopRatedMovieListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TopRatedMovieDetails(widget.movieDetails)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: ListTileTheme(
          tileColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.yellow,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: SizedBox(
              width: MediaQuery.of(context).size. width / 5, // Set a fixed width
              height:  MediaQuery.of(context).size. height / 7,
              child: Image.network(
                "https://image.tmdb.org/t/p/w342${widget.movieDetails.posterPath}",
                fit: BoxFit.cover,
              ),
            ),
            title: Text(widget.movieDetails.originalTitle ?? " "),
            subtitle: Text(widget.movieDetails.overview ?? ''),
          ),
        ),
      ),
    );
  }
}
