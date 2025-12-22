class AppConstants {
  // App Info
  static const String appName = 'Hệ thống quản lý Thư viện';
  static const String appVersion = '1.0.0';

  // Colors
  static const int primaryBlue = 0xFF1976D2;
  static const int primaryGreen = 0xFF4CAF50;
  static const int primaryOrange = 0xFFFF9800;
  static const int primaryRed = 0xFFF44336;

  // Strings
  static const String searchHint = 'Tìm kiếm...';
  static const String noResultsFound = 'Không tìm thấy kết quả';
  static const String loading = 'Đang tải...';
  static const String error = 'Có lỗi xảy ra';

  // Button Labels
  static const String add = 'Thêm';
  static const String edit = 'Sửa';
  static const String delete = 'Xóa';
  static const String cancel = 'Hủy';
  static const String save = 'Lưu';
  static const String close = 'Đóng';
  // Book Status
  static const String available = 'Có sẵn';
  static const String borrowed = 'Đã mượn';

  // Screen Titles
  static const String managementTitle = 'Tìm kiếm sách theo người dùng';
  static const String bookListTitle = 'Danh sách sách';
  static const String userListTitle = 'Danh sách người dùng';

  // Navigation Labels
  static const String managementLabel = 'Quản lý';
  static const String booksLabel = 'Danh sách sách';
  static const String usersLabel = 'Người dùng';
    // Search Hints
  static const String searchUserHint = 'Nhập tên người dùng...';
  static const String searchBookHint = 'Tìm kiếm sách...';

  // Messages
  static const String pageNotFound = 'Không tìm thấy trang';
  static const String pageNotExists = 'Trang không tồn tại';
  static const String currentUser = 'Người dùng:';
  static const String currentlyBorrowing = 'Sách đang mượn:';
  static const String enterUserNameToSearch = 'Nhập tên người dùng để tìm kiếm';
  static const String userHasNoBorrowedBooks = 'Người dùng này chưa mượn sách nào';
  
  // Book Details Labels
  static const String author = 'Tác giả:';
  static const String category = 'Thể loại:';
  static const String publishYear = 'Năm xuất bản:';
  static const String isbn = 'ISBN:';
  static const String status = 'Trạng thái:';
  
  // User Details Labels  
  static const String email = 'Email:';
  static const String phone = 'Điện thoại:';
  static const String borrowedBooksCount = 'Số sách đang mượn:';  // Navigation Labels (Updated)
  static const String searchTabLabel = 'Quản lý';
  static const String booksTabLabel = 'Sách';
  static const String usersTabLabel = 'Người dùng';

  // Borrow Book Labels
  static const String borrowBook = 'Mượn sách';
  static const String returnBook = 'Trả sách';
  static const String availableBooks = 'Sách có sẵn';
  static const String selectBookToBorrow = 'Chọn sách để mượn';  static const String borrowSuccess = 'Mượn sách thành công';
  static const String borrowFailed = 'Mượn sách thất bại';
  static const String returnSuccess = 'Trả sách thành công';
  static const String returnFailed = 'Trả sách thất bại';
  static const String alreadyBorrowed = 'Sách đã được mượn';
}
