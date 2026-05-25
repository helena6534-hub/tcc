import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C&C Turismo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6DBAAA)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _activeScreen = 'home';
  bool _showMenu = false;

  final List<Map<String, dynamic>> trips = [
    {
      'id': 1,
      'title': 'Jaguariúna + Pedreira',
      'date': '28/6',
      'image': 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=400&h=400&fit=crop',
    },
    {
      'id': 2,
      'title': 'Ibitinga + Passeio de barco',
      'date': '24-27/07',
      'image': 'https://images.unsplash.com/photo-1518639192441-8fce0a366e2e?w=400&h=400&fit=crop',
    },
    {
      'id': 3,
      'title': 'Festa do morango',
      'date': '14 a 17 de agosto',
      'image': 'https://images.unsplash.com/photo-1516306580123-e6e52b1b7b5f?w=400&h=400&fit=crop',
    },
    {
      'id': 4,
      'title': 'ZOO Itatiba',
      'date': '27/09',
      'image': 'https://images.unsplash.com/photo-1551620832-e2af54f6f0b8?w=400&h=400&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              _buildNavBar(),
              Expanded(
                child: _activeScreen == 'home'
                    ? _buildHomeScreen()
                    : _buildSobreScreen(),
              ),
            ],
          ),
          if (_showMenu) _buildDropdownMenu(),
          if (_activeScreen == 'home') _buildFAB(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF6DBAAA),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 12,
        right: 16,
        left: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => setState(() => _showMenu = !_showMenu),
            child: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 56,
      right: 16,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () => setState(() => _showMenu = false),
            child: const Text(
              'Sair da conta',
              style: TextStyle(color: Color(0xFF374151), fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    final navItems = [
      {'id': 'pacotes', 'label': 'Pacotes', 'icon': Icons.work_outline, 'screen': 'home'},
      {'id': 'promocoes', 'label': 'Promoções', 'icon': Icons.local_offer_outlined, 'screen': 'home'},
      {'id': 'agenda', 'label': 'Agenda', 'icon': Icons.calendar_today_outlined, 'screen': 'home'},
      {'id': 'sobre', 'label': 'Sobre', 'icon': Icons.group_outlined, 'screen': 'sobre'},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.map((item) {
          final isActive = _activeScreen == item['screen'] && item['screen'] == 'sobre';
          return GestureDetector(
            onTap: () => setState(() {
              _activeScreen = item['screen'] as String;
              _showMenu = false;
            }),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF6DBAAA)
                        : const Color(0xFF2C5F5A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF6DBAAA)
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Programação viagens e passeios para 2026!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),
          ...trips.map((trip) => _buildTripCard(trip)),
        ],
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              trip['image'] as String,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: const Color(0xFF6DBAAA),
                child: const Icon(Icons.image, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  trip['date'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSobreScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quem somos nós?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),

          // Foto da equipe
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'imagens/conradoecidinha.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF6DBAAA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.people, color: Colors.white, size: 60),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Descrição
          const Text(
            'A C&C Turismo é uma agência que está há mais 10 anos no mercado com o objetivo de levar pessoas para realizarem seus sonhos.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),

          // Slogan e redes sociais
          Center(
            child: Column(
              children: const [
                Text(
                  '"O melhor caminho para o seu destino!"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6DBAAA),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '@ccturismosjc',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C5F5A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Positioned(
      bottom: 32,
      right: 24,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF6DBAAA),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}