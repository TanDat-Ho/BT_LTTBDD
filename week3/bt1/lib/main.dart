import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserInputScreen(),
  ));
}

class User {
  final String? name;
  final String? email;
  final String? phone;

  const User({this.name, this.email, this.phone});
}

// Màn hình nhập thông tin user
class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Định nghĩa các label
  static const String nameLabel = 'Tên (bắt buộc)';
  static const String emailLabel = 'Email (tùy chọn)';
  static const String phoneLabel = 'Số điện thoại (tùy chọn)';

  void _createUser() {
    // Tạo user từ thông tin nhập
    User newUser = User(
      name: _nameController.text.isNotEmpty ? _nameController.text : null,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
    );

    // Chuyển đến màn hình profile với user đã tạo
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfile(user: newUser),
      ),
    );
  }

  // Helper method để tạo TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhập thông tin User"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Điền thông tin (có thể bỏ trống)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Tên
            _buildTextField(
              controller: _nameController,
              label: nameLabel,
              icon: Icons.person,
            ),
            SizedBox(height: 15),

            // Email
            _buildTextField(
              controller: _emailController,
              label: emailLabel,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),

            // Số điện thoại
            _buildTextField(
              controller: _phoneController,
              label: phoneLabel,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _createUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Tạo Profile", style: TextStyle(color: Colors.white)),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Chuyển đến profile với user null
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(user: null),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Xem profile trống", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình hiển thị profile
class UserProfile extends StatelessWidget {
  final User? user;

  const UserProfile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user == null)
              _buildNoUserWidget()
            else
              _buildUserInfoWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildNoUserWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Không có thông tin user",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              "Hãy quay lại và nhập thông tin",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),

          SizedBox(height: 30),

          _buildInfoRow("Tên", user?.name ?? "Chưa nhập tên", 
                       user?.name != null ? Colors.black : Colors.grey),

          _buildInfoRow("Email", user?.email ?? "Chưa nhập email",
                       user?.email != null ? Colors.black : Colors.grey),

          _buildInfoRow("Số điện thoại", user?.phone ?? "Chưa nhập số điện thoại",
                       user?.phone != null ? Colors.black : Colors.grey),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}