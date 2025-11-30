import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'checkout_screen.dart';

class Product {
  final String id;
  final String name;
  final String nameEn;
  final double price;
  final String category;
  final double rating;
  final bool inStock;
  final String image;
  final List<Color> gradientColors;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.price,
    required this.category,
    required this.rating,
    required this.inStock,
    required this.image,
    required this.gradientColors,
    required this.description,
  });
}

class MedicineStore extends StatefulWidget {
  final VoidCallback onBack;

  const MedicineStore({Key? key, required this.onBack}) : super(key: key);

  @override
  State<MedicineStore> createState() => _MedicineStoreState();
}

class _MedicineStoreState extends State<MedicineStore> {
  String selectedCategory = 'all';
  Map<String, int> cartItems = {};

  List<Map<String, dynamic>> get categories => [
    {'id': 'all', 'name': tr('all'), 'color': const Color(0xFF0A6DD9)},
    {
      'id': 'painkillers',
      'name': tr('painkillersCategory'),
      'color': const Color(0xFFFF9E57),
    },
    {
      'id': 'vitamins',
      'name': tr('vitaminsCategory'),
      'color': const Color(0xFF0A6DD9),
    },
    {
      'id': 'antibiotics',
      'name': tr('antibioticsCategory'),
      'color': const Color(0xFF2BB9A9),
    },
    {
      'id': 'skincare',
      'name': tr('skincareCategory'),
      'color': const Color(0xFFE9E9E9),
    },
  ];

  List<Product> get products => [
    Product(
      id: '1',
      name: tr('paracetamol500'),
      nameEn: 'Paracetamol',
      price: 25,
      category: 'painkillers',
      rating: 4.5,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
      description: tr('painkillersDesc'),
    ),
    Product(
      id: '2',
      name: tr('vitaminC1000'),
      nameEn: 'Vitamin C',
      price: 85,
      category: 'vitamins',
      rating: 4.8,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      description: tr('vitaminCDesc'),
    ),
    Product(
      id: '3',
      name: tr('digitalThermometer'),
      nameEn: 'Digital Thermometer',
      price: 120,
      category: 'devices',
      rating: 4.6,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      description: tr('thermometerDesc'),
    ),
    Product(
      id: '4',
      name: tr('amoxicillin500'),
      nameEn: 'Amoxicillin',
      price: 45,
      category: 'antibiotics',
      rating: 4.4,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
      description: tr('antibioticDesc'),
    ),
    Product(
      id: '5',
      name: tr('medicalSyringes'),
      nameEn: 'Medical Syringes',
      price: 35,
      category: 'devices',
      rating: 4.7,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFFE9E9E9), const Color(0xFFE9E9E9)],
      description: tr('syringesDesc'),
    ),
    Product(
      id: '6',
      name: tr('skinCream'),
      nameEn: 'Skin Cream',
      price: 95,
      category: 'skincare',
      rating: 4.3,
      inStock: true,
      image: 'https://via.placeholder.com/150',
      gradientColors: [const Color(0xFFE9E9E9), const Color(0xFFE9E9E9)],
      description: tr('skinCreamDesc'),
    ),
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 'all') return products;
    return products.where((p) => p.category == selectedCategory).toList();
  }

  int get totalItems => cartItems.values.fold(0, (sum, count) => sum + count);

  void addToCart(String productId) {
    setState(() {
      cartItems[productId] = (cartItems[productId] ?? 0) + 1;
    });
  }

  void removeFromCart(String productId) {
    setState(() {
      if (cartItems[productId] != null && cartItems[productId]! > 1) {
        cartItems[productId] = cartItems[productId]! - 1;
      } else {
        cartItems.remove(productId);
      }
    });
  }

  double get totalPrice {
    double total = 0;
    cartItems.forEach((id, count) {
      final product = products.firstWhere((p) => p.id == id);
      total += product.price * count;
    });
    return total;
  }

  void _navigateToCheckout() {
    final List<CartItem> checkoutItems = [];
    cartItems.forEach((id, count) {
      final product = products.firstWhere((p) => p.id == id);
      checkoutItems.add(
        CartItem(
          id: product.id,
          name: product.name,
          price: product.price,
          quantity: count,
          gradientColors: product.gradientColors,
        ),
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: checkoutItems,
          onBack: () => Navigator.pop(context),
          onOrderComplete: () {
            setState(() {
              cartItems.clear();
            });
          },
        ),
      ),
    );
  }

  void _showCartSheet() {
    final parentContext = context;
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          // Calculate total inside builder so it updates
          double sheetTotalPrice = 0;
          cartItems.forEach((id, count) {
            final product = products.firstWhere((p) => p.id == id);
            sheetTotalPrice += product.price * count;
          });

          return Container(
            height: MediaQuery.of(sheetContext).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          cartItems.clear();
                          setSheetState(() {});
                          setState(() {});
                        },
                        child: Text(
                          tr('clearCart'),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            tr('shoppingCartTitle'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFFFF9E57),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Cart Items
                Expanded(
                  child: cartItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                tr('cartEmpty'),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: cartItems.length,
                          itemBuilder: (ctx, index) {
                            final productId = cartItems.keys.elementAt(index);
                            final count = cartItems[productId]!;
                            final product = products.firstWhere(
                              (p) => p.id == productId,
                            );

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  // Quantity controls
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          addToCart(product.id);
                                          setSheetState(() {});
                                          setState(() {});
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              product.gradientColors[0],
                                          foregroundColor: Colors.white,
                                        ),
                                        icon: const Icon(Icons.add, size: 22),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          '$count',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          removeFromCart(product.id);
                                          setSheetState(() {});
                                          setState(() {});
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                          foregroundColor: count > 1
                                              ? Colors.grey[700]
                                              : Colors.red,
                                        ),
                                        icon: Icon(
                                          count > 1
                                              ? Icons.remove
                                              : Icons.delete,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          product.nameEn,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${(product.price * count).toInt()} ${tr('currency')}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: product.gradientColors[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: product.gradientColors,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.medication,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                if (cartItems.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${sheetTotalPrice.toInt()} ${tr('currency')}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF9E57),
                              ),
                            ),
                            Text(
                              tr('totalLabel'),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(sheetContext).pop();
                              Future.delayed(
                                const Duration(milliseconds: 150),
                                () => _navigateToCheckout(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9E57),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              tr('checkoutBtn'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    ).then((_) {
      // Refresh parent state when sheet closes
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildProductsGrid()),
            ],
          ),
          if (totalItems > 0) _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Decorative dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(15, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: widget.onBack,
                  ),
                  Text(
                    tr('medicineStore'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _showCartSheet();
                        },
                      ),
                      if (totalItems > 0)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2BB9A9),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$totalItems',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: tr('searchMedicine'),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Categories
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = selectedCategory == cat['id'];
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat['id']),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          cat['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.grey[800] : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.tune, color: Colors.grey[600], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      tr('filter'),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Text(
                '${filteredProducts.length} ${tr('productCount')}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Products grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final cartCount = cartItems[product.id] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Product image
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: product.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.medication,
                    size: 48,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                if (product.inStock)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tr('available'),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Product info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.nameEn,
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF9E57),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Color(0xFFFF9E57),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cart controls
                      cartCount > 0
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2BB9A9),
                                    Color(0xFF0A6DD9),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => removeFromCart(product.id),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Color(0xFF2BB9A9),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      '$cartCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => addToCart(product.id),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Color(0xFF2BB9A9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () => addToCart(product.id),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2BB9A9),
                                      Color(0xFF0A6DD9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF2BB9A9,
                                      ).withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${product.price.toInt()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tr('currency'),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: GestureDetector(
        onTap: () {
          _showCartSheet();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9E57).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$totalItems',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    tr('viewCartBtn'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${totalPrice.toInt()} ${tr('currency')}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
