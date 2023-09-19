import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/weather_cubit.dart';
import 'package:mywaether/controller/weather_states.dart';
import 'package:mywaether/methods.dart';
import 'package:mywaether/models/color_manager.dart';
import 'package:mywaether/models/images_class.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        String? weatherImage =
            getImage(
              cubit!.weatherModel!.weatherState.toLowerCase()
              );

        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              cubit!.weatherModel!.cityName,
              style: TextStyle(
                  color: ColorManager.background,
                  fontSize: 30,
                  fontFamily: kCourgette),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Last updated:  ${cubit!.weatherModel!.date}',
              style: TextStyle(color: ColorManager.background, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
          weatherImage != null
                ? Lottie.asset(
                    weatherImage,
                    height: 200,
                    width: 200,
                    animate: true)
                : const Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(height: 200,),
                    CircularProgressIndicator(),
                  ],
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                cubit!.weatherModel!.weatherState,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
            
                style: TextStyle(
                    color: ColorManager.background,
                    fontSize: 30,
                    fontFamily: kCourgette),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${cubit!.weatherModel!.temp.ceil()}$degree',
              style: TextStyle(color: ColorManager.background, fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'max: ${cubit!.weatherModel!.maxTemp.ceil()}$degree         min: ${cubit!.weatherModel!.minTemp.ceil()}$degree',
                  style: TextStyle(
                      color: ColorManager.background,
                      fontSize: 14,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        ImagesModel.sunrise,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sunrise: ${cubit!.weatherModel!.sunrise}',
                        style: TextStyle(
                            color: ColorManager.background,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        ImagesModel.sunset,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sunset: ${cubit!.weatherModel!.sunset}',
                        style: TextStyle(
                            color: ColorManager.background,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer()
            
           
          ],
        );
      },
    );
  }
}
