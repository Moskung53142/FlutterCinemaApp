import 'package:cinema/showtime.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/data/user.dart';
import 'package:cinema/showtimepage/topbar.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  String searchText = "";
  bool isNowShowing = true;

  final TextEditingController searchController = TextEditingController();

  // SEARCH FILTER
  List<movielist> get filteredMovies {
    if (searchText.isEmpty) return appMovieList;

    return appMovieList
        .where((m) => m.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // CATEGORY FILTER
  List<movielist> get categorizedMovies {
    if (isNowShowing) {
      return filteredMovies.where((m) => m.status == "now_showing").toList();
    } else {
      return filteredMovies.where((m) => m.status == "coming_soon").toList();
    }
  }

  void Logout(BuildContext context) {
    UserSessionData.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TopBar(selectedIndex: 0),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HERO BANNER
                  Stack(
                    children: [
                      Container(
                        height: 450,
                        width: double.infinity,
                        color: Colors.grey[900],
                        child: Image.asset(
                          'asset/image/avatar-fire-and-ash.webp',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        height: 450,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "อวตาร",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const Text(
                              "แฟนตาซี | 195 นาที",
                              style: TextStyle(color: Colors.grey),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "รายละเอียดภาพยนตร์ >",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    "จองตั๋ว",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // SEARCH BAR
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: TextField(
                        controller: searchController,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },

                        decoration: InputDecoration(
                          hintText: "ค้นหาภาพยนตร์...",
                          hintStyle: const TextStyle(color: Colors.grey),

                          suffixIcon: searchText.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {
                                      searchText = "";
                                    });
                                  },
                                )
                              : const Icon(Icons.search, color: Colors.red),

                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const Text(
                    "ภาพยนตร์",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // TAB SELECTOR
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Row(
                      children: [
                        // NOW SHOWING
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isNowShowing = true;
                              });
                            },

                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isNowShowing
                                    ? Colors.red
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),

                              child: Text(
                                "กำลังฉาย",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isNowShowing
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // COMING SOON
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isNowShowing = false;
                              });
                            },

                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: !isNowShowing
                                    ? Colors.red
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),

                              child: Text(
                                "โปรแกรมหน้า",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isNowShowing
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MOVIE GRID
                  GridView.builder(
                    padding: const EdgeInsets.all(32),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: categorizedMovies.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),

                    itemBuilder: (context, index) {
                      final movie = categorizedMovies[index];
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
                                  'userIndex': 0,
                                },
                              ),
                            ),
                          );
                        },

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

                                  child: Image.asset(
                                    movie.moviePic,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "วันที่เข้าฉาย: ${movie.startdate}",
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 10,
                              ),
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
                      );
                    },
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
