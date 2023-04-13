import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_values.dart';
import 'package:weather_app/featuers/weather/weather/presentation/widgets/favorite_city.dart';
import 'package:weather_app/featuers/weather/weather/presentation/widgets/favorite_city_form.dart';
import '../../../../../core/constants/colors_constants.dart';
import '../bloc/weather/weather_bloc.dart';
import '../widgets/5days_weather.dart';
import '../widgets/current_weather_container.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/general_weather_state.dart';
import '../widgets/sun_state.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsConstants.dayMainColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                )),
          ],
        ),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: Container(
            color: ColorsConstants.dayMainColor,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FullWeatherLoadingSuccessState) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CurrentWeatherContainer(state: state),
                          // FiveDaysForecast(state: state),
                          SunState(state: state),
                          GeneralWeatherState(state: state),
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorsConstants.elevatedButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ConstantDoubles.d_12),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FiveDaysForecast(
                                              state: state,
                                            )),
                                  ),
                              child: const Text("Next 5 days")),
                        ],
                      ),
                    );
                  } else if (state is FullWeatherLoadingFailState) {
                    return Center(
                      child: Text(state.failMessage),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ));
  }
}
