import 'package:get_it/get_it.dart';
import 'package:traveller_app/_app_lib/notifiers/app_page_notifier.dart';
import 'package:traveller_app/data/api/traveller_data_mockup.dart';
import 'package:traveller_app/data/bloc/route_bloc.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';

import '../data/bloc/ticket_bloc.dart';

GetIt locator = GetIt.instance;

void setupApi(){
  // Repo pattern with Dependency Injection
  // Can now easily change ImageDataHTTP to another Data access layer that implements IApiImages.
  locator.registerLazySingleton<IApiTraveller>(() => TravellerDataMockup());
  locator.registerLazySingleton(() => AppPageNotifier());
  locator.registerLazySingleton(() => RouteBloc());
  locator.registerLazySingleton(() => TicketBloc());
}