import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtime.dart';
import 'package:cinema/showtimepage/topbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MovieScreen()),
  );
}

class MovieScreen extends StatefulWidget {
  final int userIndex;
  const MovieScreen({super.key, this.userIndex = 0});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String searchText = "";
  final TextEditingController searchController = TextEditingController();

  // SEARCH FILTER
  List<movielist> get filteredMovies {
    if (searchText.isEmpty) return appMovieList;

    return appMovieList
        .where((m) => m.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // NOW SHOWING
  List<movielist> get nowShowingMovies {
    return filteredMovies.where((m) => m.status == "now_showing").toList();
  }

  // COMING SOON
  List<movielist> get comingSoonMovies {
    return filteredMovies.where((m) => m.status == "coming_soon").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(selectedIndex: 1),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,

                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  decoration: const InputDecoration(
                    hintText: "ค้นหาภาพยนตร์...",
                    suffixIcon: Icon(Icons.search, color: Colors.red),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOW SHOWING
                    _sectionTitle("กำลังฉาย", Colors.yellow),
                    _movieRow(context, nowShowingMovies),
                    const SizedBox(height: 20),

                    _sectionTitle("โปรแกรมหน้า", Colors.red),
                    _movieRow(context, comingSoonMovies),
                    const SizedBox(height: 20),

                    _sectionTitle("โปรโมชั่น", Colors.white),
                    _promotionBanner(),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color underlineColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 12),
      child: IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(height: 2,  color: underlineColor),
        ],
      ),
    ),
    );

  }

  Widget _movieRow(BuildContext context, List<movielist> movies) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;
    final cardHeight = cardWidth / 0.65;

    return SizedBox(
      height: cardHeight,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),

        itemCount: movies.length,

        itemBuilder: (context, index) {
          final movie = movies[index];
          final movieIndex = appMovieList.indexOf(movie);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShowtimeScreen(),
                  settings: RouteSettings(
                    arguments: {
                      'movieIndex': movieIndex,
                      'userIndex': widget.userIndex,
                    },
                  ),
                ),
              );
            },

            child: Container(
              width: cardWidth,
              margin: const EdgeInsets.only(right: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),

                        child: Image.asset(movie.moviePic, fit: BoxFit.cover),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "วันที่เข้าฉาย: ${movie.startdate}",

                    style: const TextStyle(color: Colors.yellow, fontSize: 10),

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    movie.title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _promotionBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),

        child: Image.asset(
          'asset/image/Promotion1.jpg',
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
