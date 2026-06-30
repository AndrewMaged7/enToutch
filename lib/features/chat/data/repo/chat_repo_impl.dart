import 'dart:convert';
// import 'dart:io';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
// import 'package:en_touch/core/models/extract_audio_from_video_model.dart';
import 'package:en_touch/core/routes/global_key.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/chat/data/models/message_class.dart';
import 'package:en_touch/features/chat/data/models/text_to_sign_chat_model.dart';
import 'package:en_touch/features/chat/data/source/chat_data_source.dart';
import 'package:en_touch/features/chat/data/source/chat_data_source_impl.dart';
import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:video_player/video_player.dart';
// import 'package:web/src/dom/fileapi.dart';

class ChatRepoImpl extends ChatRepository {
  ChatDataSource chatDataSource = ChatDataSourceImpl();
  AppServices appServices = AppServices();
  HubConnection? _connection;
  bool get _isConnected => _connection?.state == HubConnectionState.Connected;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late AndroidNotificationChannel channel;

  @override
  Future<void> connectWithSignalR() async {
    if (_isConnected) return;
    final token = HiveCacheHelper.getData<AuthModel>("authData")?.token;
    if (token == null || token.isEmpty) {
      throw StateError('Missing auth token for SignalR connection');
    }
    print("==================================");
    print(token);
    _connection = HubConnectionBuilder()
        .withUrl(
          "https://entouch.runasp.net/chatHub",
          options: HttpConnectionOptions(accessTokenFactory: () async => token),
        )
        .build();
    await _connection!.start();
  }

  @override
  Future sendMessage({
    required String receiverId,
    required String content,
    required String messageType,
    String mediaUrl = "",
  }) async {
    try {
      if (!_isConnected) {
        await connectWithSignalR();
      }
      await _connection!.invoke(
        "SendPrivateMessage",
        args: [receiverId, content, messageType, mediaUrl],
      );
      print("===============Message Sent $content");
    } on Exception catch (e) {
      print("SignalR error: ${e.toString()}");
      rethrow;
    }
  }

  @override
  void receiveMessage(Function(MessageModel message) callback) async {
    if (!_isConnected) {
      await connectWithSignalR();
    }
    _connection?.on("ReceivePrivateMessage", (args) {
      if (args == null || args.isEmpty) return;
      final rawData = args[0];
      if (rawData is! Map) return;
      final data = Map<String, dynamic>.from(rawData);
      final message = MessageModel.fromJson(data);
      callback(message);
    });
  }

  @override
  Future<List<MessageModel>> getChatConversations(String userID) async {
    try {
      var response = await chatDataSource.getChatConversations(userID);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List data = response.data;
        return data.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<VideoPlayerController> playVideo(String videoPath) async {
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));
      await controller.initialize();
      await controller.play();
      return controller;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> getMessageToken() async {
    await setSettings();
    String? messageToken = await messaging.getToken();
    print("================================== Message Token");
    print(messageToken);
    print("==================================");
    await HiveCacheHelper.saveData("messageToken", messageToken);
    return messageToken ?? "";
  }

  @override
  Future<void> setSettings() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    await flutterLocalNotificationsPlugin.show(
      id: message.hashCode,
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? '',
      notificationDetails: const NotificationDetails(android: androidDetails),
      payload: jsonEncode(message.data),
    );

  }

Future<void> setupNotificationNavigation() async {
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("OPENED FROM BACKGROUND");
    print(message.data);

    final senderId = message.data['senderId'];

    GlobalKeys.navigatorKey.currentState?.pushNamed(
      Routes.chats,
      arguments: senderId,
    );
  });

  final initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    print("OPENED FROM TERMINATED");
    print(initialMessage.data);

    final senderId = initialMessage.data['senderId'];

    
    await GlobalKeys.navigatorKey.currentState?.pushNamed(
        Routes.chats,
        arguments: senderId,
      );
    
  }
}

  @override
  Future<void> foregroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      final title = notification?.title ?? message.data['title'];
      final body = notification?.body ?? message.data['body'];
      if (title == null && body == null) return;
      await flutterLocalNotificationsPlugin.show(
        id: message.hashCode,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),

        // final chatId = data['senderId'];
      );
    });
  }

  Future<void> initLocalNotifications() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);


    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      
      onDidReceiveNotificationResponse: (details) {
        print("===================================== Details");
        print("CLICKED");
        print(details.payload);
        final data = jsonDecode(details.payload!);
        final chatId = data['senderId'];
        GlobalKeys.navigatorKey.currentState?.pushNamed(Routes.chats, arguments: chatId);
      },
       
    );


  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Opened From Background");
    print(message.data);

    final senderId = message.data['senderId'];

    if (senderId != null) {
      GlobalKeys.navigatorKey.currentState?.pushNamed(
        Routes.chats,
        arguments: senderId,
      );
    }
  });
   
   final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    print("Opened From Terminated");
    print(initialMessage.data);

    final senderId = initialMessage.data['senderId'];

        if (senderId != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalKeys.navigatorKey.currentState?.pushNamed(
        Routes.chats,
        arguments: senderId,
      );
    });
  }

      
    
  }
   
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> setPermissions() async {
    final plugin = FlutterLocalNotificationsPlugin();

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }


  @override
  Future<TextToSignChatModel> sendText(String text) async {
    try {
      var response = await chatDataSource.sendText(text);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return TextToSignChatModel.fromJson(response.data);
      } else {
        throw Exception('Failed to send text ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<ExtractAudioFromVideoModel> extractAudioFromVideo(File videoPath) {
  //   var response = chatDataSource.extractAudioFromVideo(videoPath);
  //   if(response.hashCode >= 200 && response.hashCode <= 299){
  //     print("Extract Audio From Video Response: ${response.hashCode} ${response}");
  //     var model =  response.then((value) => ExtractAudioFromVideoModel.fromJson(value!.data));
  //     print("Extract Audio From Video Model: ${model}");
  //     return model;
  //   } else {
  //     throw Exception('Failed to extract audio from video ${response.hashCode}');
  //   }
  // }
} 























// import 'package:en_touch/features/chat/data/source/chat_data_source_impl.dart';
// import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

// class ChatRepositoryImpl implements ChatRepository {

//   final ChatRemoteDataSource remoteDataSource;

//   ChatRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<void> connect() {
//     return remoteDataSource.connect();
//   }

//   @override
//   Future<void> sendMessage(
//       String senderId,
//       String receiverId,
//       String message
//       ) {

//     return remoteDataSource.sendMessage(
//         senderId,
//         receiverId,
//         message
//     );
//   }

//   @override
//   void receiveMessage(Function(dynamic) onMessage) {

//     remoteDataSource.receiveMessage(onMessage);

//   }

// }
















// // import 'package:dartz/dartz.dart';
// // import 'package:en_touch/core/errors/app_errors.dart';
// // import 'package:en_touch/features/chat/data/models/chat_model.dart';
// // import 'package:en_touch/features/chat/data/source/chat_data_source.dart';
// // import 'package:en_touch/features/chat/data/source/chat_data_source_impl.dart';
// // import 'package:en_touch/features/chat/domain/repo/chat_repo.dart';

// // class ChatRepoImpl extends ChatRepo {
// //   ChatDataSource chatDataSource = ChatDataSourceImpl();

// //   @override
// //   Future<Either<AppErrors, ChatMessage>> fetchMessages() async {
// //     try {
// //       final message = await chatDataSource.fetchMessages();
// //       return Right(message);
// //     } catch(e) {
// //       return Left(AppErrors(e.toString()));
// //     }
// //   }

// //   @override
// //   Future<Either<AppErrors, ChatMessage>> sendMessage(String text, String userId) async {
// //     try {
// //       final message = await chatDataSource.sendMessage(text, userId);
// //       return Right(message);
// //     } catch(e) {
// //       return Left(AppErrors(e.toString()));
// //     }
// //   }

// // }