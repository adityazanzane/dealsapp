import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search here',
              prefixIcon: Image.asset('assets/images/smallicon.png'),
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            
          ),
          
        ),
    
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductCard(),
            _buildKYCPendingCard(),
            _buildCategoryIcons(),
            _buildExclusiveOffers(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProductCard() {
    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/card.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildKYCPendingCard() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 122, 97, 205),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'KYC Pending',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28),
            child: Text(
              'You need to provide the required documents for your account activation.',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Click Here',
            style: TextStyle(color: Colors.white, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCategoryItem(Icons.phone_android, 'Mobile', Colors.blueAccent),
          _buildCategoryItem(Icons.laptop, 'Laptop', Colors.green),
          _buildCategoryItem(Icons.camera_alt, 'Camera', Colors.redAccent),
          _buildCategoryItem(Icons.lightbulb, 'LED', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 25,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildExclusiveOffers() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EXCLUSIVE FOR YOU', style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildOfferCard('32% Off', 'assets/images/mobone.png'),
              _buildOfferCard('14% Off', 'assets/images/mobtwo.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(String discount, String imageUrl) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imageUrl, fit: BoxFit.cover, height: double.infinity),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(discount, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.diamond), label: 'Deals'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}