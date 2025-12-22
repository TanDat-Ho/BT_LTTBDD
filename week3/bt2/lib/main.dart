import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaymentScreen(),
  ));
}

class PaymentMethod {
  final String id;
  final String name;
  final String logo;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.logo,
  });
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentId; // Nullable

  // Danh sách các phương thức thanh toán với assets
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'paypal',
      name: 'PayPal',
      logo: 'assets/images/paypal.png',
    ),
    PaymentMethod(
      id: 'googlepay',
      name: 'GooglePay',
      logo: 'assets/images/ggpay.png',
    ),
    PaymentMethod(
      id: 'applepay',
      name: 'ApplePay',
      logo: 'assets/images/applepay.png',
    ),
  ];

  // Method để lấy logo hiển thị (OOP)
  String _getCurrentLogo() {
    if (selectedPaymentId != null) {
      // Tìm payment method đã chọn
      PaymentMethod? selectedMethod = paymentMethods
          .where((method) => method.id == selectedPaymentId)
          .firstOrNull;
      
      return selectedMethod?.logo ?? 'assets/images/wallet.png';
    }
    return 'assets/images/wallet.png'; // Default wallet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo thay đổi theo selection
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  _getCurrentLogo(), // Sử dụng method để lấy logo
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback nếu không load được ảnh
                    return Icon(
                      Icons.account_balance_wallet,
                      size: 60,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 40),

            // PayPal Container với ListTile
            _buildPaymentTile('paypal', 'PayPal', 'assets/images/paypal.png'),

            SizedBox(height: 20),

            // GooglePay Container với ListTile
            _buildPaymentTile('googlepay', 'GooglePay', 'assets/images/ggpay.png'),

            SizedBox(height: 20),

            // ApplePay Container với ListTile
            _buildPaymentTile('applepay', 'ApplePay', 'assets/images/applepay.png'),

            SizedBox(height: 30),

            // Continue Button - chỉ hiển thị UI, không có chức năng
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedPaymentId != null ? () {} : null, // Empty function - chỉ để hiển thị
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPaymentId != null 
                      ? Colors.blue 
                      : Colors.grey.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
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

  // Helper method để tạo payment tile (OOP - tránh lặp code)
  Widget _buildPaymentTile(String id, String name, String logoPath) {
    bool isSelected = selectedPaymentId == id;
    
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected 
                ? Colors.blue.withOpacity(0.3) 
                : Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        leading: Radio<String>(
          value: id,
          groupValue: selectedPaymentId, // Nullable
          onChanged: (String? value) { // Nullable callback
            setState(() {
              selectedPaymentId = value; // Logo sẽ thay đổi
            });
          },
          activeColor: Colors.blue,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 25,
          child: Image.asset(
            logoPath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.credit_card, color: Colors.grey);
            },
          ),
        ),
        onTap: () {
          setState(() {
            selectedPaymentId = id; // Logo sẽ thay đổi
          });
        },
      ),
    );
  }
}

// Extension để sử dụng firstOrNull
extension ListExtension<T> on List<T> {
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}