import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'core/app_theme/app_theme.dart';
import 'featuers/weather/weather/presentation/bloc/favorite_city/bloc/favorite_city_bloc.dart';
import 'featuers/weather/weather/presentation/bloc/other_locations/other_locations_bloc.dart';
import 'featuers/weather/weather/presentation/pages/home.dart';
import 'featuers/weather/weather/presentation/pages/manage_locations.dart';
import 'debendency_container.dart' as di;
import 'featuers/weather/weather/presentation/bloc/weather/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);
  await di.init();
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<WeatherBloc>()..add(GetFullWeatherEvent())),
        BlocProvider(
            create: (_) =>
                di.sl<OtherLocationsBloc>()..add(GetAllSavedLocationsEvent())),
        BlocProvider(
            create: (_) =>
                di.sl<FavoriteCityBloc>()..add(GetFavoriteCityEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        theme: AppTheme.theme,
        home: const ManageLocations(),
        routes: {
          ManageLocations.routName: (context) => const ManageLocations(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
