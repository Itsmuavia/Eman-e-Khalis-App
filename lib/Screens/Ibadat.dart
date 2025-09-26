import 'dart:async';
import 'package:emane_khalis_app/Screens/Fastingpage.dart';
import 'package:emane_khalis_app/Screens/Hadithpage.dart';
import 'package:emane_khalis_app/Screens/Hajjumrahpage.dart';
import 'package:emane_khalis_app/Screens/Prayerpage.dart';
import 'package:emane_khalis_app/Screens/QnA.dart';
import 'package:emane_khalis_app/Screens/Zakatpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    "assets/images/thumbnail3.png",
  ];

  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> ibadatItems = [
    {"titleEn": "Prayer", "icon": FontAwesomeIcons.personPraying},
    {"titleEn": "Fasting", "icon": FontAwesomeIcons.moon},
    {"titleEn": "Hajj / Umrah", "icon": FontAwesomeIcons.kaaba},
    {"titleEn": "Zakat", "icon": FontAwesomeIcons.handHoldingDollar},
    {
      "titleEn": "Hadith",
      "icon": MdiIcons.bookOpenPageVariant,
      // "icon": FontAwesomeIcons.bookQuran,
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

  List<Map<String, dynamic>> _filterList() {
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
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              'Ibadat',
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

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 7,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return GestureDetector(
                            onTap: () {
                              Widget nextPage;
                              switch (item["titleEn"]) {
                                case "Prayer":
                                  nextPage = Prayerpage();
                                  break;
                                case "Fasting":
                                  nextPage = Fastingpage();
                                  break;
                                case "Hajj / Umrah":
                                  nextPage = HajjUmrahPage();
                                  break;
                                case "Zakat":
                                  nextPage = Zakatpage();
                                case "Hadith":
                                  nextPage = Hadithpage();
                                  break;
                                default:
                                  nextPage = const Scaffold(
                                    body: Center(child: Text("Page not found")),
                                  );
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => nextPage,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF052B65), // deep blue
                                    Color(0xFF2785E5), // lighter blue
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade900.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: const Offset(3, 5),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.amber.shade400,
                                  width: 2,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/islamic_pattern.png",
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 0.2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.amber.shade400,
                                          Colors.amber.shade200,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amber.shade200
                                              .withOpacity(0.6),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: FaIcon(
                                      item['icon'] as IconData,
                                      size: 32,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    item["titleEn"]!,
                                    style: TextStyle(
                                      fontFamily: "ScheherazadeNew",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(1, 2),
                                          blurRadius: 3,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
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
