import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tafseer extends StatefulWidget {
  const Tafseer({super.key});

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late TabController _tabController;

  final List<Map<String, String>> surahData = [
    {
      "number": "1",
      "name": "Al-Fatihah",
      "place": "Meccah",
      "verses": "7 Verses",
      "arabic": "ٱلْفَاتِحَةُ",
    },
    {
      "number": "2",
      "name": "Al-Baqarah",
      "place": "Medinah",
      "verses": "286 Verses",
      "arabic": "ٱلْبَقَرَةُ",
    },
    {
      "number": "3",
      "name": "Āl ʿImrān",
      "place": "Medinah",
      "verses": "200 Verses",
      "arabic": "آلِ عِمْرَانَ",
    },
    {
      "number": "4",
      "name": "An-Nisāʾ",
      "place": "Medinah",
      "verses": "176 Verses",
      "arabic": "ٱلنِّسَاءُ",
    },
    {
      "number": "5",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ",
    },
    {
      "number": "6",
      "name": "Al-An’am",
      "place": "Meccah",
      "verses": "165 Verses",
      "arabic": "ٱلْأَنْعَامُ",
    },
    {
      "number": "7",
      "name": "Al-A’raf",
      "place": "Meccah",
      "verses": "206 Verses",
      "arabic": "ٱلْأَعْرَافُ",
    },
    {
      "number": "8",
      "name": "Al-Anfal",
      "place": "Medinah",
      "verses": "75 Verses",
      "arabic": "ٱلْأَنْفَالُ",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSurah = surahData.where((surah) {
      final number = surah["number"]!;
      final name = surah["name"]!.toLowerCase();
      final arabic = surah["arabic"]!;
      return name.contains(_searchQuery) ||
          arabic.contains(_searchQuery) ||
          number.contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 400;
            final isTablet = constraints.maxWidth > 600;

            return Column(
              children: [
                // 🔹 Header + Search
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Container(
                              width: isSmallScreen ? 38 : 44,
                              height: isSmallScreen ? 38 : 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade700,
                                    Colors.blue.shade400,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'تَفْسِير',
                                  style: GoogleFonts.scheherazadeNew(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 12 : 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "Quran Tafseer",
                                style: GoogleFonts.scheherazadeNew(
                                  fontSize: isSmallScreen ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: isSmallScreen ? 32 : 35,
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
                                    hintText: 'Search Surah...',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
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
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 6.0),
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

                // 🔹 TabBar
                Material(
                  color: Colors.transparent,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.blue.shade800,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3, color: Colors.amber),
                    ),
                    tabs: const [
                      Tab(icon: Icon(Icons.menu_book), text: "Surah"),
                      Tab(icon: Icon(Icons.layers), text: "Juz"),
                      Tab(icon: Icon(Icons.bookmark), text: "Bookmarks"),
                    ],
                  ),
                ),

                // 🔹 Responsive Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Surah List
                      filteredSurah.isEmpty
                          ? Center(
                        child: Text(
                          _searchQuery.isNotEmpty
                              ? "Not Found"
                              : "No Surah available",
                          style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            fontSize: isSmallScreen ? 13 : 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          : ListView.builder(
                        itemCount: filteredSurah.length,
                        itemBuilder: (context, index) {
                          final surah = filteredSurah[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.shade800,
                                child: Text(
                                  surah["number"]!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    isSmallScreen ? 11 : 13,
                                  ),
                                ),
                              ),
                              title: Text(
                                surah["name"]!,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 13 : 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                "${surah["place"]} | ${surah["verses"]}",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 11 : 12,
                                  color: Colors.blueGrey.shade400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Wrap(
                                spacing: isSmallScreen ? 4 : 6,
                                children: [
                                  Text(
                                    surah["arabic"]!,
                                    style: GoogleFonts.lateef(
                                      fontSize:
                                      isSmallScreen ? 17 : 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.download,
                                        color: Colors.blue.shade700,
                                        size:
                                        isSmallScreen ? 20 : 24),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.play_arrow,
                                        color: Colors.green.shade700,
                                        size:
                                        isSmallScreen ? 20 : 24),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.open_in_new,
                                        color: Colors.amber.shade700,
                                        size:
                                        isSmallScreen ? 20 : 24),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Juz tab
                      const Center(child: Text("Juz Content Coming Soon")),

                      // Bookmarks tab
                      const Center(child: Text("Bookmarks will appear here")),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
