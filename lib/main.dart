import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/simple_bloc_observer.dart';
import 'package:mywaether/models/cache_helper.dart';

import 'package:mywaether/views/search_screen.dart';
import 'package:mywaether/views/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await CacheHelper.init();

  cityName = CacheHelper.getString(key: kCityName) ?? cityName;
  isFirst = CacheHelper.getBool(key: kIsFirst) ?? true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirst ? const WelcomeScreen() : const SearchScreen(),
    );
  }
}
