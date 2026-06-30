import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/auth/presentation/screens/forget_pass_screen.dart';
import 'package:en_touch/features/auth/presentation/screens/send_new_pass_screen.dart';
import 'package:en_touch/features/auth/presentation/screens/send_otp_screen.dart';
import 'package:en_touch/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:en_touch/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:en_touch/features/boarding/on_boarding.dart';
import 'package:en_touch/features/camera/presentation/screens/result_for_camera_screen.dart';
import 'package:en_touch/features/camera/presentation/screens/camera_screen.dart';
import 'package:en_touch/features/chat/presentation/screens/chat_screen.dart';
import 'package:en_touch/features/community/presentation/screens/add_post_screen.dart';
import 'package:en_touch/features/dictionary/presentation/screen/dictionary_screen.dart';
import 'package:en_touch/features/history/presentation/screen/history_screen.dart';
import 'package:en_touch/features/home/presentation/screen/home_screen.dart';
import 'package:en_touch/features/learn%20new%20sign/presentation/screens/learn_new_sign_screen.dart';
import 'package:en_touch/features/main/screen/main_screen.dart';
import 'package:en_touch/features/community/presentation/screens/community.dart';
import 'package:en_touch/features/setting/presentation/screen/chats.dart';
import 'package:en_touch/features/setting/presentation/screen/language_and_mode_screen.dart';
import 'package:en_touch/features/setting/presentation/screen/profile.dart';
import 'package:en_touch/features/setting/presentation/screen/requests.dart';
import 'package:en_touch/features/setting/presentation/screen/setting_screen.dart';
import 'package:en_touch/features/setting/presentation/screen/suggestions.dart';
import 'package:flutter/material.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case Routes.forgetPass:
        return MaterialPageRoute(builder: (_) => ForgetPassScreen());
      case Routes.sendOtp:
        return MaterialPageRoute(builder: (_) => SendOtpScreen(),settings: settings);
      case Routes.sendNewPass:
        return MaterialPageRoute(builder: (_) => SendNewPassScreen(),settings: settings);
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoarding());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainScreen(),settings: settings);
      case Routes.setting:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case Routes.camera:
        return MaterialPageRoute(builder: (_) => CameraScreen(),settings: settings);
      case Routes.answerScreen:
        return MaterialPageRoute(builder: (_) => AnswerScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => Profile());
      case Routes.chats:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(), settings: settings);
      case Routes.homeChats:
        return MaterialPageRoute(
            builder: (_) => Chats());
      case Routes.suggestions:
        return MaterialPageRoute(builder: (_) => Suggestions());
      case Routes.requests:
        return MaterialPageRoute(builder: (_) => Requests());
      case Routes.community:
        return MaterialPageRoute(builder: (_) => Community());
      case Routes.addPost:
        return MaterialPageRoute(builder: (_) => AddPostScreen());
      case Routes.history:
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case Routes.dictionary:
        return MaterialPageRoute(builder: (_) => DictionaryScreen());
      // case Routes.textToSign:
      //   return MaterialPageRoute(builder: (_) => TextToSignScreen());
      case Routes.languageAndModeScreen:
        return MaterialPageRoute(builder: (_) => LanguageAndModeScreen());
      case Routes.learnNewSign:
        return MaterialPageRoute(builder: (_) => LearnNewSignScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}