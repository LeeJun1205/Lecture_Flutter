import 'dart:async';

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.content,
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return '[$timestamp] $sender: $content';
  }
}

class ChatRoom {
  final Set<String> participants = {};
  final List<Message> messageHistory = [];
  final Map<String, bool> alertSettings = {};

  final StreamController<Message> _messageStreamController = StreamController<Message>.broadcast();

  // 참가자 추가
  void addParticipant(String user) {
    participants.add(user);
    alertSettings[user] = true; // 기본값으로 알림 활성화
    print('$user has joined the chat room.');
  }

  // 참가자 제거
  void removeParticipant(String user) {
    participants.remove(user);
    alertSettings.remove(user);
    print('$user has left the chat room.');
  }

  // 메시지 전송
  Future<void> sendMessage(String sender, String content) async {
    if (!participants.contains(sender)) {
      print('Error: $sender is not in the chat room.');
      return;
    }

    // 메시지 지연 시뮬레이션
    await Future.delayed(Duration(seconds: 1));
    final message = Message(sender: sender, content: content);
    messageHistory.add(message);
    _messageStreamController.add(message); // 실시간 스트림에 메시지 추가
    print(message);

    // 알림 전송
    _notifyParticipants(sender, content);
  }

  // 실시간 메시지 스트림
  Stream<Message> get messageStream => _messageStreamController.stream;

  // 알림 설정 관리
  void setAlert(String user, bool enabled) {
    if (alertSettings.containsKey(user)) {
      alertSettings[user] = enabled;
      print('Alert for $user has been ${enabled ? 'enabled' : 'disabled'}.');
    } else {
      print('Error: $user is not in the chat room.');
    }
  }

  // 알림 처리
  void _notifyParticipants(String sender, String content) {
    for (var user in participants) {
      if (user != sender && alertSettings[user] == true) {
        print('Notification to $user: New message from $sender - "$content"');
      }
    }
  }

  // 채팅방 상태 출력
  void showStatus() {
    print('Participants: $participants');
    print('Message History:');
    for (var message in messageHistory) {
      print(message);
    }
  }

  // 자원 정리
  void close() {
    _messageStreamController.close();
  }
}

void main() async {
  final chatRoom = ChatRoom();

  chatRoom.addParticipant('KillOne');
  chatRoom.addParticipant('Jun');
  chatRoom.addParticipant('DuDu');

  // 메시지 스트림 구독
  chatRoom.messageStream.listen((message) {
    print('Stream received: $message');
  });

  await chatRoom.sendMessage('KillOne', 'Hello, everyone!');
  await chatRoom.sendMessage('Jun', 'Hi KillOne!');
  chatRoom.setAlert('DuDu', false); // DuDu의 알림 비활성화
  await chatRoom.sendMessage('DuDu', 'Hey!');

  chatRoom.showStatus();

  chatRoom.removeParticipant('KillOne');
  chatRoom.close();
}
