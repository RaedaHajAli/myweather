import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/weather_cubit.dart';
import 'package:mywaether/controller/weather_states.dart';

import 'package:mywaether/models/color_manager.dart';
import 'package:mywaether/views/components/popular_city.dart';

import 'package:mywaether/views/components/weather_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()
        ..getWeather(cityName: cityName)
        ..getPopularCities(),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        body: const ScreenBody(),
      ),
    );
  }
}

class ScreenBody extends StatelessWidget {
  const ScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = WeatherCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              const WeatherCard(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Popular Cities',
                          style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 23,
                              fontFamily: kCourgette),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      condition: cubit!.citiesModel.length == 2,
                      builder: (context) {
                        return ListView.separated(
                          itemBuilder: (context, index) => PopularCity(
                            model: cubit!.citiesModel[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: cubit!.citiesModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                        );
                      },
                      fallback: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
