import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/weather_cubit.dart';
import 'package:mywaether/controller/weather_states.dart';
import 'package:mywaether/models/color_manager.dart';
import 'package:mywaether/views/components/search_field.dart';
import 'package:mywaether/views/components/weather_details.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    super.key,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool inAsync = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (context, state) {
      if (state is GetWeatherLoadingState || state is GetLocationLoadingState) {
        inAsync = true;
      } else {
        inAsync = false;
      }
    }, builder: (context, state) {
      return Container(
        height: 670,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        child: ModalProgressHUD(
          inAsyncCall: inAsync,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 65,
              ),
              const SeachField(),
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit!.weatherModel != null,
                  builder: (context) {
                    return const WeatherDetails();
                  },
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
