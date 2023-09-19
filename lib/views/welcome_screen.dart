import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/models/cache_helper.dart';
import 'package:mywaether/models/color_manager.dart';
import 'package:mywaether/models/images_class.dart';
import 'package:mywaether/views/search_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Lottie.asset(ImagesModel.welcome,
                height: 250, width: 250, animate: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          'Weather',
                          style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 35,
                              fontFamily: kCairo),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Forecasts App.',
                        style:
                            TextStyle(color: ColorManager.white, fontSize: 28),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    weatherDesc,
                    style: TextStyle(color: ColorManager.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                    CacheHelper.setData(key: kIsFirst, value: false);
                  },
                  child: Text(
                    'Get started',
                    style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 23,
                        fontFamily: kCourgette),
                  )),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
