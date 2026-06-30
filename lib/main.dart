import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/observer/observer.dart';
import 'package:en_touch/core/routes/global_key.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/core/routes/routes_generator.dart';
import 'package:en_touch/core/theme/cubit/theme_cubit.dart';
import 'package:en_touch/core/theme/presentation/dark_theme.dart';
import 'package:en_touch/core/theme/presentation/light_theme.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:en_touch/features/chat/data/repo/chat_repo_impl.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:en_touch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runZonedGuarded(() async {
    try {
      await EasyLocalization.ensureInitialized();
      await Hive.initFlutter();
      Hive.registerAdapter(AuthModelAdapter());
      await HiveCacheHelper.init('appCache');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseMessaging.instance.requestPermission();
    } catch (e, stack) {
      debugPrint('INIT ERROR: $e');
      debugPrint('STACK: $stack');
    }

    final chatRepo = ChatRepoImpl();
    final bool isEnglish = HiveCacheHelper.getData<bool>('isEnglish') ?? true;
    Bloc.observer = MyBlocObserver();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'images/translations',
        fallbackLocale: const Locale('en'),
        startLocale: isEnglish ? const Locale('en') : const Locale('ar'),
        child: MyApp(),
      ),
    );

    try {
      await chatRepo.getMessageToken();
      await chatRepo.initLocalNotifications();
      await chatRepo.foregroundNotification();
      await chatRepo.setupNotificationNavigation();
      FirebaseMessaging.onBackgroundMessage(
        ChatRepoImpl.firebaseMessagingBackgroundHandler,
      );
      await FirebaseMessaging.instance.getInitialMessage();
    } catch (e, stack) {
      debugPrint('POST INIT ERROR: $e');
      debugPrint('STACK: $stack');
    }
  }, (error, stack) {
    debugPrint('UNCAUGHT ERROR: $error');
    debugPrint('STACK: $stack');
  });
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(AuthModelAdapter());
//   await HiveCacheHelper.init('appCache');
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await FirebaseMessaging.instance.requestPermission();
//   final chatRepo = ChatRepoImpl();

//   final bool isEnglish = HiveCacheHelper.getData<bool>('isEnglish') ?? true;
//   Bloc.observer = MyBlocObserver();

//   runApp(
//     EasyLocalization(
//       supportedLocales: const [
//         Locale('en'),
//         Locale('ar'),
//       ],
//       path: 'images/translations',
//       fallbackLocale: const Locale('en'),
//       startLocale:
//           isEnglish ? const Locale('en') : const Locale('ar'),
//       child: MyApp(),
//     ),
//   );
//   await chatRepo.getMessageToken();
//   await chatRepo.initLocalNotifications();
//   await chatRepo.foregroundNotification();
//   await chatRepo.setupNotificationNavigation();
//   FirebaseMessaging.onBackgroundMessage(
//     ChatRepoImpl.firebaseMessagingBackgroundHandler,
//   );
//   await FirebaseMessaging.instance.getInitialMessage();
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final bool isFirstTime =
      HiveCacheHelper.getData<bool>('isFirstTime') ?? true;
  final bool isLogged =
      HiveCacheHelper.getData<bool>('logged') ?? false;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => SettingCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final isDark =
                  context.read<ThemeCubit>().isDark;
              return MaterialApp(
                navigatorKey: GlobalKeys.navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode:
                    isDark ? ThemeMode.dark : ThemeMode.light,
                localizationsDelegates:
                    context.localizationDelegates,
                supportedLocales:
                    context.supportedLocales,
                locale: context.locale,
                initialRoute: isFirstTime
                    ? Routes.onBoarding
                    : (isLogged
                          ? Routes.main
                          : Routes.signIn),
                onGenerateRoute:
                    RoutesGenerator.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}