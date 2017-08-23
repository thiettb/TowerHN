![](/assets/Simulator Screen Shot Aug 23, 2017, 10.49.22.png)iTowerHaNoi written by Tran Ba Thiet

Language: Swift

MIT license

# 1.Mô tả thuật toán:

Để hiểu được giải thuật cho bài toán tháp Hà Nội đầu tiên ta phải biết được cách giải bài toán với số đĩa là 1 và 2.

Ta quy ước:

```
        Cột A: là cột đầu chứa tất cả các đĩa

        Cột B: là cột trung gian

        Cột C: là cột đích
```

Nếu chỉ có 1 đĩa thì ta di chuyển từ cột A -&gt; cột C -&gt; done  
Nếu có 2 đĩa:

```
        Đầu tiên ta di chuyển đĩa trên cùng ở cột A -> cột B

        Sau đó di chuyển đĩa còn lại ở cột A -> cột C

        Và cuối cùng di chuyển đĩa từ cột B -> cột C
```

Từ 2 trường hợp trên ta đưa ra bài toán đệ quy cho bài toán tháp Hà Nội với số lượng &gt; 3 đĩa

Ta giả sử có n đĩa đc sắp xếp từ lớn đến bé trên cột A.Bài toán quy về chuyển đĩa thứ n từ cột A

qua cột C và sau đó đặt tất cả \(n-1\) đĩa còn lại lên.Giải thuật sẽ như sau:

B1: Di chuyển n-1 đĩa từ cột A tới cột trung B

B2: Di chuyển đĩa thứ n từ cột A tới cột C

B3: Di chuyển n-1 đĩa còn lại từ cột B tới cột C

# 2.Animation

Mô phỏng đĩa di chuyển cho từng Step của thuật toán

Mỗi Step trong thuật toán nó sẽ trả về vị trí tháp đầu đến tháp cuối và sau Step đó nó sẽ cập nhật xoá đĩa mà đã được di chuyển ở Tháp From và thêm 1 đĩa ở Tháp To

Mỗi lần di chuyển Đĩa sẽ đi lên rồi đi ngang sau đó đi xuống =&gt; Tương ứng với nó ta sẽ tạo ra 3 hàm để miêu tả hành động cho nó.

Mỗi Step trong thuật toán ta sẽ cho nó Animation tương ứng với Step đó. Vì animation sẽ là liên tục đĩa 1 di chuyển xong thì đĩa 2 di chuyển nên tránh bị gián đoạn nên ta sẽ dùng đệ quy cho hàm Animation\(\) với điều kiện dừng là chính bằng số lần cần di chuyển mà thuật toán trả về.

# 3.Một số hình ảnh giao diện
![](/assets/2.png)
![](/assets/3.png)
![](/assets/4.png)
![](/assets/5.png)
