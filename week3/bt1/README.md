## Tìm hiểu về Nullable
# Thế nào là nullable
    Nullable là khái niệm trong lập trình cho phép một biến có thể chứa giá trị null (rỗng/không có giá trị), giúp code an toàn và rõ ràng hơn về mặt ý nghĩa!

# Khi nào nên không nên dùng 
    Nên dùng nullable khi:
    Giá trị tùy chọn (Optional)
    Dữ liệu chưa được tải
    Form validation
    API response có thể thiếu

    Không nên dùng nullable khi:
    Giá trị luôn tồn tại
    ID hoặc key quan trọng
    Configuration cơ bản

# Cách thức xử lí null phổ biến như: ?, ?., ?:, let, !!
    1. Null-aware operator (?.)
    2. Null coalescing operator (??)
    3. Null assertion (!)
    4. Conditional access với if
    5. Late keyword (khởi tạo sau)
    6. Pattern matching với switch
