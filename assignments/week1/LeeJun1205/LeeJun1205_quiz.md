1번 답 : 2
이유 : final은 런타임 중에 값이 결정될 수 있고 한번만 값을 할당할 수 있다.
      Const는 컴파일 타임에 값이 결정되어야 한다. 변하지 않는 상수다.

2번 답 : name이 Null 값이다. 초기화하지 않은 변수를 사용했다. 
이유 : Dart는 null-safety를 따른다. 변수를 초기화하거나, 변수는 nullable로 선언하거나 late 키워드를 사용해야 한다.

3번 답 : [6, 8, 10]
이유 : 2보다 큰 값 [3, 4, 5]에만 2를 곱해서 [6, 8, 10]을 만들고 이것을 출력한다.

4번 답 : 네트워크에서 데이터를 가져오거나 데이터베이스 쓰기, 파일 읽기 등의 작업은 상황에 따라 언제 끝날지 알 수 없으므로 비동기로 처리한다.
이유 : 동기 방식으로만 처리하면 어떤 작업을 하는데 시간이 오래 걸리면 사용자는 이것을 종료할 수 있다.

5번 답 : 
class Person {
  String name;
  int age;

  Person({required this.name, required this.age});
}
이유 : null-safety 때문에 non-nullable 변수 String과 int를 초기화하지 않으면 오류가 발생한다. Required를 사용해서 값이 반드시 있어야 하는 것을 알려야 한다.

6번 답 : Set
이유 : 중복을 허용하지 않는 것은 Set 밖에 없다.

7번 답 : void print_hello() => print("hello");

8번 답 : 문제점->nullable 변수에 대해 null 체크 없이 non-nullable 변수로 사용하려함.
수정 방법 : 
void printUserInfo(String? name) {
  String displayName = name ?? "Unknown"; 
  print(displayName.toUpperCase());
}
