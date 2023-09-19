import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/weather_cubit.dart';
import 'package:mywaether/controller/weather_states.dart';
import 'package:mywaether/methods.dart';
import 'package:mywaether/models/color_manager.dart';

import 'package:mywaether/models/weather_model.dart';

class PopularCity extends StatelessWidget {
  const PopularCity({
    super.key,
    required this.model,
  });
  final WeatherModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        
        String? image = getStaticImage(model.weatherState.toLowerCase());
        return Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(25)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${model.cityName}, ${model.countryName}',
              style: TextStyle(
                  color: ColorManager.background,
                  fontSize: 16,
                  fontFamily: kCairo),
            ),
            Row(
              children: [
                Text(
                  '${model.temp.ceil()}$degree',
                  style: TextStyle(
                      color: ColorManager.background,
                      fontSize: 16,
                      fontFamily: kCairo),
                ),
                const SizedBox(
                  width: 15,
                ),
                image != null
                    ? Image.asset(
                        image,
                        height: 40,
                        width: 40,
                      )
                    : const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator())
              ],
            )
          ]),
        );
      },
    );
  }
}
