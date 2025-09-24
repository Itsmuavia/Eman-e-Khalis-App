import 'package:carousel_slider/carousel_slider.dart';
import 'package:emane_khalis_app/Screens/Videodetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _carouselIndex = 0;

  late TabController _tabController; // 👈 TabController

  final List<String> images = [
    'assets/images/applogo.png',
    'assets/images/applogo.png',
    'assets/images/applogo.png',
    'assets/images/applogo.png',
  ];

  final List<Map<String, String>> videos = [
    {
      'title':
          'Surah Aal-e-Imran Ayat 92-101 Quran Tilawat & Translation in Urdu ',
      'writer': 'Fawad Shah',
      'duration': '6:53',
      'thumbnail': 'assets/images/thumbnail1.png',
      'url': 'assets/videos/Surah Aal-e-Imran Ayat. 92-101.mp4',
    },
    {
      'title': 'Surah Tawbah Rukoo#2 Quran Tilawat & Tafseer in Urdu ',
      'writer': 'Furqan ul Huda',
      'duration': '16:47',
      'thumbnail': 'assets/images/thumbnail2.png',
      'url': 'assets/videos/Surah At-Tawbah.mp4',
    },
    {
      'title':
          'Surah Aal-e-Imran Ayat 21-30 Quran Tilawat & Translation in Urdu ',
      'writer': 'Fawad Shah',
      'duration': '8:16',
      'thumbnail': 'assets/images/thumbnail4.png',
      'url': 'assets/videos/Surah Aal-e-Imran Ayat 21-30.mp4',
    },
  ];

  final List<Map<String, String>> articles = [
    {
      'title': 'Importance of Salah',
      'author': 'Imam Ahmed',
      'thumbnail': 'assets/images/thumbnail1.png',
      'description': 'This article explains the importance of Salah in Islam.',
    },
    {
      'title': 'Benefits of Fasting',
      'author': 'Maulana Rashid',
      'thumbnail': 'assets/images/thumbnail2.png',
      'description': 'Learn the physical and spiritual benefits of fasting.',
    },
  ];

  final List<Map<String, String>> ebooks = [
    {
      'title': 'Quran Tafseer (Urdu)',
      'author': 'Scholar A',
      'thumbnail': 'assets/images/thumbnail1.png',
      'description': 'Comprehensive Tafseer of the Holy Quran in Urdu.',
    },
    {
      'title': 'Hadith Collection Vol 1',
      'author': 'Scholar B',
      'thumbnail': 'assets/images/thumbnail2.png',
      'description': 'Authentic collection of Hadith with commentary.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    _tabController = TabController(length: 3, vsync: this); // 👈 init tabs
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose(); // 👈 dispose
    super.dispose();
  }

  List<Map<String, String>> _filterList(
    List<Map<String, String>> list,
    List<String> keys,
  ) {
    if (_searchQuery.isEmpty) return list;
    return list.where((item) {
      for (var key in keys) {
        final value = item[key];
        if (value != null && value.toLowerCase().contains(_searchQuery)) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final filteredVideos = _filterList(videos, ['title', 'writer', 'duration']);
    final filteredArticles = _filterList(articles, [
      'title',
      'author',
      'thumbnail',
    ]);
    final filteredEbooks = _filterList(ebooks, [
      'title',
      'author',
      'thumbnail',
    ]);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient:LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  // Branding Left
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'اِيمَان',
                              style: GoogleFonts.scheherazadeNew(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Pure Faith',
                              style: GoogleFonts.scheherazadeNew(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search Box
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 6),
                          const Icon(Icons.search, color: Colors.blueGrey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Search ......',
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.search,
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.clear,
                                  size: 18,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Scrollable Body ---
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.blue.shade50],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: width * 0.4,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.92,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _carouselIndex = index;
                                    });
                                  },
                                ),
                                items: images.map((imgUrl) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(imgUrl, fit: BoxFit.cover),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade900.withOpacity(
                                                0.18,
                                              ),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: images.asMap().entries.map((entry) {
                                  return Container(
                                    width: _carouselIndex == entry.key ? 16 : 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _carouselIndex == entry.key
                                          ? Colors.blue.shade700
                                          : Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.blue.shade800,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.blueGrey,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3, color: Colors.amber),
                        insets: EdgeInsets.zero,
                      ),
                      tabs: [
                        Tab(icon: Icon(Icons.ondemand_video), text: "Videos"),
                        Tab(icon: Icon(Icons.article), text: "Articles"),
                        Tab(icon: Icon(Icons.menu_book), text: "E-Books"),
                      ],
                    ),
                    SizedBox(
                      height: 500,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Videos
                          filteredVideos.isEmpty
                              ? _emptyPlaceholder('No videos found.')
                              : ListView(
                                  children: filteredVideos
                                      .map((v) => _buildVideoCard(v))
                                      .toList(),
                                ),

                          // Articles
                          filteredArticles.isEmpty
                              ? _emptyPlaceholder('No articles found.')
                              : ListView(
                                  children: filteredArticles
                                      .map((a) => _buildArticleCard(a))
                                      .toList(),
                                ),

                          // Ebooks
                          filteredEbooks.isEmpty
                              ? _emptyPlaceholder('No ebooks found.')
                              : ListView(
                                  children: filteredEbooks
                                      .map((e) => _buildEbookCard(e))
                                      .toList(),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Empty State ---
  Widget _emptyPlaceholder(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(text, style: TextStyle(color: Colors.blueGrey.shade400)),
      ),
    );
  }

  // --- Video Card ---
  Widget _buildVideoCard(Map<String, String> video) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Videodetails(video: video)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      video['thumbnail'] ?? '',
                      width: 110,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        video['duration'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.play_arrow, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'By ${video['writer']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Videodetails(video: video),
                    ),
                  );
                },
                child: Icon(Icons.play_circle, color: Colors.blue.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            article['thumbnail'] ?? '',
            width: 74,
            height: 74,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          article['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          article['description'] ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('By', style: TextStyle(color: Colors.blueGrey.shade400)),
            const SizedBox(height: 4),
            Text(
              article['author'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildEbookCard(Map<String, String> ebook) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            ebook['thumbnail'] ?? '',
            width: 74,
            height: 74,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          ebook['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          ebook['description'] ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('By', style: TextStyle(color: Colors.blueGrey.shade400)),
            const SizedBox(height: 4),
            Text(
              ebook['author'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
