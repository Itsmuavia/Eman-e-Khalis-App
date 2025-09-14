import 'dart:async';
import 'package:emane_khalis_app/Screens/Bottomnavbar.dart';
import 'package:emane_khalis_app/Screens/Loginpage.dart';
import 'package:emane_khalis_app/Screens/ProfilePage.dart';
import 'package:emane_khalis_app/Screens/QnA.dart';
import 'package:emane_khalis_app/Screens/Signuppage.dart';
import 'package:emane_khalis_app/Screens/Tafseer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Ibadat extends StatefulWidget {
  const Ibadat({super.key});

  @override
  State<Ibadat> createState() => _IbadatState();
}

class _IbadatState extends State<Ibadat> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> bannerImages = [
    "assets/images/thumbnail1.png",
    "assets/images/thumbnail2.png",
    "assets/images/quran.png",
  ];

  int _currentIndex = 0;
  Timer? _timer;

  // 🔹 Ab har item me route add kar diya future navigation ke liye
  final List<Map<String, String>> ibadatItems = [
    {"titleEn": "Prayer", "titleUr": "نماز", "icon": "🕌"},
    {"titleEn": "Fasting", "titleUr": "روزہ", "icon": "🌙"},
    {"titleEn": "Hajj / Umrah", "titleUr": "حج / عمرہ", "icon": "🕋"},
    {"titleEn": "Namaz-e-Janaza", "titleUr": "نماز جنازہ", "icon": "⚰️"},
    {"titleEn": "Zakat", "titleUr": "زکوٰۃ", "icon": "💰"},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % bannerImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filterList() {
    if (_searchQuery.isEmpty) return ibadatItems;
    return ibadatItems.where((item) {
      return item["titleEn"]!.toLowerCase().contains(_searchQuery) ||
          item["titleUr"]!.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filterList();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Fixed Top Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFe6f0fb), Color(0xFFdff3ff)],
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
                              'عِبَادَات',
                              style: GoogleFonts.scheherazadeNew(
                                color: Colors.white,
                                fontSize: 11,
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
                              'عِبَادَات',
                              style: GoogleFonts.scheherazadeNew(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueGrey.shade800,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              'Ibadat',
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 36,
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

            // 🔹 Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      height: 180,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: Image.asset(
                            bannerImages[_currentIndex],
                            key: ValueKey<String>(bannerImages[_currentIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return GestureDetector(
                            onTap: () {
                              Widget nextPage;

                              switch (item["titleEn"]) {
                                case "Prayer":
                                  nextPage = LoginPage();
                                  break;
                                case "Fasting":
                                  nextPage = Signuppage();
                                  break;
                                case "Hajj":
                                  nextPage = Tafseer();
                                  break;
                                case "Umrah":
                                  nextPage = ProfilePage();
                                  break;
                                case "Namaz-e-Janaza":
                                  nextPage = Bottomnavbar();
                                  break;
                                case "Zakat":
                                  nextPage = Qna();
                                  break;
                                default:
                                  nextPage = const Scaffold(
                                    body: Center(child: Text("Page not found")),
                                  );
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => nextPage),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade50,
                                    Colors.blue.shade100
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.shade100
                                        .withOpacity(0.6),
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.blue.shade200,
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item["icon"]!,
                                      style: const TextStyle(fontSize: 40)),
                                  const SizedBox(height: 10),
                                  Text(
                                    item["titleEn"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  Text(
                                    item["titleUr"]!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueGrey.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
}
