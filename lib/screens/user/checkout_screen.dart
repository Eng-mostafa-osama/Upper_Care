import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final IconData? icon;
  final List<Color>? gradientColors;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.icon,
    this.gradientColors,
  });

  double get totalPrice => price * quantity;
}

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback onBack;
  final VoidCallback? onOrderComplete;

  const CheckoutScreen({
    Key? key,
    required this.cartItems,
    required this.onBack,
    this.onOrderComplete,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  bool isProcessing = false;
  String selectedPaymentMethod = 'cash';

  // Address Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Card Controllers
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    governorateController.dispose();
    landmarkController.dispose();
    notesController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  double get subtotal =>
      widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => subtotal > 500 ? 0 : 30;
  double get discount => subtotal > 1000 ? subtotal * 0.1 : 0;
  double get total => subtotal + deliveryFee - discount;

  List<Map<String, dynamic>> get paymentMethods => [
    {
      'id': 'cash',
      'name': tr('cashOnDelivery'),
      'icon': Icons.money,
      'color': const Color(0xFF4CAF50),
    },
    {
      'id': 'card',
      'name': tr('creditCard'),
      'icon': Icons.credit_card,
      'color': const Color(0xFF0A6DD9),
    },
    {
      'id': 'wallet',
      'name': tr('mobileWallet'),
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFFFF9E57),
    },
    {
      'id': 'instapay',
      'name': tr('instaPay'),
      'icon': Icons.phone_android,
      'color': const Color(0xFF9C27B0),
    },
  ];

  List<String> get governorates => [
    tr('aswan'),
    tr('qena'),
    tr('sohag'),
    tr('luxor'),
    tr('redSea'),
    tr('newValley'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9), Color(0xFF2BB9A9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildStepIndicator(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF121212)
                        : const Color(0xFFF5F7FA),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _buildCurrentStep(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: currentStep > 0
                ? () => setState(() => currentStep--)
                : widget.onBack,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              tr('checkout'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.cartItems.length} ${tr('items')}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = [
      {'icon': Icons.location_on, 'label': tr('address')},
      {'icon': Icons.payment, 'label': tr('payment')},
      {'icon': Icons.check_circle, 'label': tr('confirm')},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep;
          final isCompleted = index < currentStep;

          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : steps[index]['icon'] as IconData,
                    color: isActive
                        ? const Color(0xFF0A6DD9)
                        : Colors.white.withOpacity(0.5),
                    size: 20,
                  ),
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildAddressStep();
      case 1:
        return _buildPaymentStep();
      case 2:
        return _buildConfirmStep();
      default:
        return _buildAddressStep();
    }
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _addressFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSectionTitle(tr('deliveryAddress'), Icons.location_on),
            const SizedBox(height: 20),

            _buildTextField(
              controller: fullNameController,
              label: tr('fullName'),
              hint: tr('enterFullName'),
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('fieldRequired');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: phoneController,
              label: tr('phoneNumber'),
              hint: '01XXXXXXXXX',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('fieldRequired');
                }
                if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                  return tr('invalidPhone');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              label: tr('governorate'),
              hint: tr('selectGovernorate'),
              icon: Icons.map,
              value: governorateController.text.isEmpty
                  ? null
                  : governorateController.text,
              items: governorates,
              onChanged: (value) {
                setState(() {
                  governorateController.text = value ?? '';
                });
              },
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: cityController,
              label: tr('cityVillage'),
              hint: tr('enterCityVillage'),
              icon: Icons.location_city,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('fieldRequired');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: addressController,
              label: tr('streetAddress'),
              hint: tr('enterStreetAddress'),
              icon: Icons.home,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('fieldRequired');
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: landmarkController,
              label: tr('landmark'),
              hint: tr('enterLandmark'),
              icon: Icons.place,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: notesController,
              label: tr('deliveryNotes'),
              hint: tr('enterDeliveryNotes'),
              icon: Icons.note,
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            _buildNextButton(tr('continueToPayment'), () {
              if (_addressFormKey.currentState!.validate() &&
                  governorateController.text.isNotEmpty) {
                setState(() => currentStep = 1);
              } else if (governorateController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('selectGovernorate')),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _paymentFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSectionTitle(tr('paymentMethod'), Icons.payment),
            const SizedBox(height: 20),

            ...paymentMethods.map((method) => _buildPaymentOption(method)),

            if (selectedPaymentMethod == 'card') ...[
              const SizedBox(height: 24),
              _buildSectionTitle(tr('cardDetails'), Icons.credit_card),
              const SizedBox(height: 16),

              _buildTextField(
                controller: cardNumberController,
                label: tr('cardNumber'),
                hint: 'XXXX XXXX XXXX XXXX',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (selectedPaymentMethod == 'card') {
                    if (value == null || value.isEmpty) {
                      return tr('fieldRequired');
                    }
                    if (value.replaceAll(' ', '').length < 16) {
                      return tr('invalidCardNumber');
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: cardHolderController,
                label: tr('cardHolderName'),
                hint: tr('enterCardHolderName'),
                icon: Icons.person,
                validator: (value) {
                  if (selectedPaymentMethod == 'card') {
                    if (value == null || value.isEmpty) {
                      return tr('fieldRequired');
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: expiryController,
                      label: tr('expiryDate'),
                      hint: 'MM/YY',
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (selectedPaymentMethod == 'card') {
                          if (value == null || value.isEmpty) {
                            return tr('fieldRequired');
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: cvvController,
                      label: tr('cvv'),
                      hint: 'XXX',
                      icon: Icons.lock,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (selectedPaymentMethod == 'card') {
                          if (value == null || value.isEmpty) {
                            return tr('fieldRequired');
                          }
                          if (value.length < 3) {
                            return tr('invalidCvv');
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],

            if (selectedPaymentMethod == 'wallet' ||
                selectedPaymentMethod == 'instapay') ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tr('walletInstructions'),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),
            _buildOrderSummaryCard(),
            const SizedBox(height: 24),

            _buildNextButton(tr('reviewOrder'), () {
              if (selectedPaymentMethod == 'card') {
                if (_paymentFormKey.currentState!.validate()) {
                  setState(() => currentStep = 2);
                }
              } else {
                setState(() => currentStep = 2);
              }
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildSectionTitle(tr('orderSummary'), Icons.receipt_long),
          const SizedBox(height: 20),

          // Delivery Address Card
          _buildInfoCard(
            title: tr('deliveryAddress'),
            icon: Icons.location_on,
            color: const Color(0xFF2BB9A9),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullNameController.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phoneController.text,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  '${addressController.text}, ${cityController.text}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  governorateController.text,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                if (landmarkController.text.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${tr('landmark')}: ${landmarkController.text}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ],
            ),
            onEdit: () => setState(() => currentStep = 0),
          ),
          const SizedBox(height: 16),

          // Payment Method Card
          _buildInfoCard(
            title: tr('paymentMethod'),
            icon: Icons.payment,
            color: const Color(0xFFFF9E57),
            content: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: paymentMethods
                        .firstWhere(
                          (m) => m['id'] == selectedPaymentMethod,
                        )['color']
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    paymentMethods.firstWhere(
                          (m) => m['id'] == selectedPaymentMethod,
                        )['icon']
                        as IconData,
                    color:
                        paymentMethods.firstWhere(
                              (m) => m['id'] == selectedPaymentMethod,
                            )['color']
                            as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  paymentMethods.firstWhere(
                        (m) => m['id'] == selectedPaymentMethod,
                      )['name']
                      as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onEdit: () => setState(() => currentStep = 1),
          ),
          const SizedBox(height: 16),

          // Order Items Card
          _buildOrderItemsCard(),
          const SizedBox(height: 16),

          // Price Summary Card
          _buildPriceSummaryCard(),
          const SizedBox(height: 24),

          // Place Order Button
          _buildPlaceOrderButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2BB9A9), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 2),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(hint, style: TextStyle(color: Colors.grey[400])),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey[400]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method) {
    final isSelected = selectedPaymentMethod == method['id'];

    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = method['id']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? method['color'] as Color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (method['color'] as Color).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (method['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                method['icon'] as IconData,
                color: method['color'] as Color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                method['name'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? method['color'] as Color
                      : Colors.grey[300]!,
                  width: 2,
                ),
                color: isSelected
                    ? method['color'] as Color
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          _buildPriceRow(
            tr('subtotal'),
            '${subtotal.toStringAsFixed(0)} ${tr('egp')}',
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            tr('deliveryFee'),
            deliveryFee == 0
                ? tr('free')
                : '${deliveryFee.toStringAsFixed(0)} ${tr('egp')}',
            valueColor: deliveryFee == 0 ? const Color(0xFF4CAF50) : null,
          ),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _buildPriceRow(
              tr('discount'),
              '-${discount.toStringAsFixed(0)} ${tr('egp')}',
              valueColor: const Color(0xFF4CAF50),
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildPriceRow(
            tr('total'),
            '${total.toStringAsFixed(0)} ${tr('egp')}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color:
                valueColor ??
                (isTotal ? const Color(0xFF0A6DD9) : const Color(0xFF1A1A2E)),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget content,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tr('edit'),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildOrderItemsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A6DD9).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Color(0xFF0A6DD9),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${tr('orderItems')} (${widget.cartItems.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.cartItems.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: item.gradientColors != null
                  ? LinearGradient(colors: item.gradientColors!)
                  : const LinearGradient(
                      colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                    ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.icon ?? Icons.shopping_bag,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${tr('quantity')}: ${item.quantity}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${item.totalPrice.toStringAsFixed(0)} ${tr('egp')}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF0A6DD9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildWhitePriceRow(
            tr('subtotal'),
            '${subtotal.toStringAsFixed(0)} ${tr('egp')}',
          ),
          const SizedBox(height: 8),
          _buildWhitePriceRow(
            tr('deliveryFee'),
            deliveryFee == 0
                ? tr('free')
                : '${deliveryFee.toStringAsFixed(0)} ${tr('egp')}',
          ),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _buildWhitePriceRow(
              tr('discount'),
              '-${discount.toStringAsFixed(0)} ${tr('egp')}',
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('totalAmount'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)} ${tr('egp')}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhitePriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isProcessing ? null : _placeOrder,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isProcessing
                  ? [Colors.grey[400]!, Colors.grey[500]!]
                  : [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: isProcessing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        tr('placeOrder'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _placeOrder() async {
    setState(() => isProcessing = true);

    // Simulate order processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isProcessing = false);

    // Show success dialog
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildSuccessDialog(),
      );
    }
  }

  Widget _buildSuccessDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF2BB9A9)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            Text(
              tr('orderPlaced'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              tr('orderConfirmationMessage'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0A6DD9).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${tr('orderNumber')}: #${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A6DD9),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onOrderComplete?.call();
                  widget.onBack();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A6DD9),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  tr('backToHome'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





