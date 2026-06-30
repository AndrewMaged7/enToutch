// // 







// // import 'package:en_touch/core/cache/cache_helper.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:en_touch/core/cache/hive_cach_helper.dart';

// class CheckInternetImpl {
//   Future<bool> isConnected() async {
//     await Future.delayed(const Duration(milliseconds: 1500));
//     final connectivity = Connectivity();
//     final result = await connectivity.checkConnectivity();
//     final hasNetwork = result != ConnectivityResult.none;

//     if (hasNetwork) {
//       print('Connected to the internet');
//       // CacheHelper.init();
//       await HiveCacheHelper.saveData('isConnected', true);
//     } else {
//       print('Disconnected from the internet');
//       await HiveCacheHelper.saveData('isConnected', false);
//     }

//     return hasNetwork;
//   }
// }
