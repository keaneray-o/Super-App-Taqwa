import 'dart:async'; //timer countdown
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // carousel slider
import 'package:http/http.dart' as http; // ambil data API JSON
import 'dart:convert'; // decode json
import 'package:geolocator/geolocator.dart'; // GPS
import 'package:geocoding/geocoding.dart'; // konversi GPS
import 'package:intl/intl.dart'; // formatter number
import 'package:permission_handler/permission_handler.dart'; // izin handler
import 'package:shared_preferences/shared_preferences.dart'; // cache lokal
import 'package:string_similarity/string_similarity.dart'; // fuzzy match

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final posterLIst = const <String>[
    'assets/images/ramadhan-kareem.png',
    'assets/images/idl-fitr.png',
    'assets/images/idl-adh.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //======================
            //MENU SECTION
            //======================
            _buildMenuGridSection(),
            //======================
            //CAROUSEL SECTION
            //=======================
            _buildCarouselSection(),
          ],
        ),
      ),
    );
  }
  //=========================
  //MENU GRID SECTION WIDGET
  //========================

  Widget _buildMenuItem(
    String iconPath,
    String title,
    String routname
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 35,),
            const SizedBox(height: 6,),
            Text(title, 
            style:  TextStyle(
              fontFamily: 'PoppinsRegular', 
              fontSize: 13),)
          ],
        ),
      ),
    );
  }
 //=========================
  //MENU GRID SECTION WIDGET
  //========================
Widget _buildMenuGridSection(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuItem(
          'assets/images/ic_menu_doa.png',// iconpath
          'Doa Harian',//title
          '/doa'//routname
          ),
        _buildMenuItem(
          'assets/images/ic_menu_dzikir.png',
          'Dzikir Harian',
          '/dzikir'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_jadwal_sholat.png',
          'jadwal sholat Harian',
          '/jadwal sholat'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_video_kajian.png',
          'video kajidan Harian',
          '/video kajian'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_zakat.png',
          'Zakat Harian',
          '/zakat'
        ),
      ],
    ),
  );
}
  //=================
  //CAROUSEL SECTION WIDGET
  //=================
  Widget _buildCarouselSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        //CAROUSEL CARD
        CarouselSlider.builder(
          itemCount: posterLIst.length,
          itemBuilder: (context, index, realIndex) {
            final poster = posterLIst[index];
            return Container(
              margin: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset(
                  poster,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            height: 300,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        //DOT INDIKATOR
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posterLIst.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _currentIndex.animateToPage(entry.key),
              child: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key 
                  ? Colors.amber 
                  : Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension on int {
  void animateToPage(int key) {}
}
