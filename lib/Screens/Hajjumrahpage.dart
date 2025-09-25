import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HajjUmrahPage extends StatefulWidget {
  const HajjUmrahPage({super.key});

  @override
  State<HajjUmrahPage> createState() => _HajjUmrahPageState();
}

class _HajjUmrahPageState extends State<HajjUmrahPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> hajjList = [
    {
      "number": "1",
      "title": "مکہ سے منی روانگی",
      "subtitle": "منی ki taraf rawangi ki dua",
      "english": "Departure from Makkah to Mina",
    },
    {
      "number": "2",
      "title": "منی آمد",
      "subtitle": "Mina pohanchne ki dua",
      "english": "Arrival at Mina",
    },
    {
      "number": "3",
      "title": "عرفات قیام",
      "subtitle": "Arafat me wuqoof",
      "english": "Stay at Arafat",
    },
  ];

  final List<Map<String, dynamic>> umrahList = [
    {
      "number": "1",
      "title": "عمرہ نیت",
      "subtitle": "Umrah start karne ki niyat",
      "english": "Intention for Umrah",
    },
    {
      "number": "2",
      "title": "طواف",
      "subtitle": "Kaaba ka tawaf",
      "english": "Tawaf around Kaaba",
    },
    {
      "number": "3",
      "title": "سعی",
      "subtitle": "Safa aur Marwa ki sa'i",
      "english": "Sa'i between Safa and Marwa",
    },
  ];

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// Top Header (Branding + Search)
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
                              _tabController.index == 0 ? "حج" : "عمرہ",
                              style: GoogleFonts.scheherazadeNew(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _tabController.index == 0 ? "Hajj" : "Umrah",
                          style: GoogleFonts.scheherazadeNew(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Search Box
                  Expanded(
                    flex: 5,
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
                                hintText: 'Search...',
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
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.blueGrey),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.yellow.shade700,
                  ),
                  insets: const EdgeInsets.symmetric(horizontal: 40),
                ),
                labelColor: Colors.blue.shade900,
                unselectedLabelColor: Colors.black54,
                labelStyle: GoogleFonts.scheherazadeNew(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(
                    icon:Icon(FontAwesomeIcons.kaaba,size: 22,color: Colors.green,),
                    text: "Hajj",
                  ),
                  Tab(
                    icon: Icon(Icons.star, size: 22, color: Colors.orange),
                    // icon added
                    text: "Umrah",
                  ),
                ],
                onTap: (i) {
                  setState(() {
                    _animationController.reset();
                    _animationController.forward();
                  });
                },
              ),
            ),


            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCardList(hajjList),
                  _buildCardList(umrahList),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardList(List<Map<String, dynamic>> dataList) {
    final filtered = dataList.where((item) {
      final title = (item["title"] ?? '').toLowerCase();
      final subtitle = (item["subtitle"] ?? '').toLowerCase();
      final english = (item["english"] ?? '').toLowerCase();
      final number = (item["number"] ?? '').toLowerCase();

      return title.contains(_searchQuery) ||
          subtitle.contains(_searchQuery) ||
          english.contains(_searchQuery) ||
          number.contains(_searchQuery);
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 55, color: Colors.blue.shade200),
            const SizedBox(height: 16),
            Text(
              "No results for '$_searchQuery'",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade800),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return SlideTransition(
          position: _slideAnimation,
          child: _buildPrayerCard(filtered[index]),
        );
      },
    );
  }

  Widget _buildPrayerCard(Map<String, dynamic> prayer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shadowColor: Colors.amber.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
              const SizedBox(width: 12),

              /// Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      prayer["title"] ?? '',
                      style: GoogleFonts.lateef(
                        fontSize: 26,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prayer["english"] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      prayer["subtitle"] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey.shade600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// Number Circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    prayer["number"] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
