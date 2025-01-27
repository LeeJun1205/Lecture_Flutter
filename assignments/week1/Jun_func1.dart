import 'dart:async';

// Book 클래스 정의
class Book {
  String title; // 도서 제목
  String author; // 저자
  bool isAvailable; // 대출 가능 여부

  Book(this.title, this.author, this.isAvailable);

  @override
  String toString() {
    return 'Book(title: $title, author: $author, isAvailable: $isAvailable)';
  }
}

// Library 클래스 정의
class Library {
  List<Book> books = []; // 도서 목록
  final StreamController<List<Book>> _bookStreamController =
      StreamController<List<Book>>.broadcast();

  // 도서 목록에 대한 실시간 업데이트 스트림
  Stream<List<Book>> get bookStream => _bookStreamController.stream;

  // 도서 추가 기능
  void addBook(Book book) {
    books.add(book);
    _updateStream();
  }

  // 도서 대출 기능
  bool borrowBook(String title) {
    for (var book in books) {
      if (book.title == title && book.isAvailable) {
        book.isAvailable = false;
        _updateStream();
        return true;
      }
    }
    return false;
  }

  // Stream 업데이트
  void _updateStream() {
    _bookStreamController.add(List.from(books));
  }

  // 자원 관리 기능
  void dispose() {
    _bookStreamController.close();
  }
}

// 테스트 코드
void main() {
  final library = Library();

  // 실시간 스트림 구독
  library.bookStream.listen((books) {
    print('Updated Book List:');
    for (var book in books) {
      print(book);
    }
  });

  // 도서 추가
  library.addBook(Book('Book A', 'Author A', true));
  library.addBook(Book('Book B', 'Author B', true));

  // 도서 대출
  library.borrowBook('Book A');

  // 리소스 해제
  library.dispose();
}
