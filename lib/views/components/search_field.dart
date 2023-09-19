import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywaether/constants.dart';
import 'package:mywaether/controller/weather_cubit.dart';
import 'package:mywaether/controller/weather_states.dart';
import 'package:mywaether/models/color_manager.dart';

class SeachField extends StatefulWidget {
  const SeachField({
    super.key,
  });

  @override
  State<SeachField> createState() => _SeachFieldState();
}

class _SeachFieldState extends State<SeachField> {
  TextEditingController cityController = TextEditingController();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: ColorManager.boldBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: cityController,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 14,
                      fontFamily: kCairo,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Choose a city',
                      hintStyle: TextStyle(
                        color: ColorManager.white,
                        fontSize: 14,
                        fontFamily: kCairo,
                      ),
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        cubit!.getWeather(cityName: value);
                        cityController.clear();
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {
                          
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    cubit!.getCurrentPosition(context).then((value) {
                      cubit!.getWeather(lat: cubit!.lat, long: cubit!.long);
                    });
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: ColorManager.blue,
                  ))
            ],
          ),
        );
      },
    );
  }
}
