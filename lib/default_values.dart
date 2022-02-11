import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';

import 'package:trufi_core/base/pages/about.dart';
import 'package:trufi_core/base/pages/feedback/feedback.dart';
import 'package:trufi_core/base/pages/feedback/translations/feedback_localizations.dart';
import 'package:trufi_core/base/pages/home/home.dart';
import 'package:trufi_core/base/pages/saved_places/saved_places.dart';
import 'package:trufi_core/base/pages/saved_places/translations/saved_places_localizations.dart';
import 'package:trufi_core/base/pages/transport_list/transport_list.dart';
import 'package:trufi_core/base/pages/transport_list/widgets/transport_list_detail/transport_list_detail.dart';
import 'package:trufi_core/base/widgets/drawer/menu/menu_item.dart';
import 'package:trufi_core/base/widgets/drawer/trufi_drawer.dart';
import 'package:trufi_core/base/widgets/screen/screen_helpers.dart';
import 'package:trufi_core/base/blocs/localization/trufi_localization_cubit.dart';
import 'package:trufi_core/base/pages/home/map_route_cubit/map_route_cubit.dart';
import 'package:trufi_core/base/pages/saved_places/repository/search_location/default_search_location.dart';
import 'package:trufi_core/base/pages/saved_places/search_locations_cubit/search_locations_cubit.dart';
import 'package:trufi_core/base/pages/transport_list/route_transports_cubit/route_transports_cubit.dart';
import 'base/blocs/localization/trufi_localization_cubit.dart';
import 'base/pages/home/widgets/trufi_map_route/trufi_map_route.dart';

abstract class BikeAppDefaultValues {
  static List<BlocProvider> blocProviders({
    required String otpEndpoint,
    required String otpGraphqlEndpoint,
    required MapConfiguration mapConfiguration,
  }) {
    return [
      ...DefaultValues.blocProviders(
        otpEndpoint: otpEndpoint,
        otpGraphqlEndpoint: otpGraphqlEndpoint,
        mapConfiguration: mapConfiguration,
      ),
    ];
  }
}

abstract class DefaultValues {
  static TrufiLocalization trufiLocalization() => const TrufiLocalization(
        currentLocale: Locale("en"),
        localizationDelegates: [
          SavedPlacesLocalization.delegate,
          FeedbackLocalization.delegate,
        ],
        supportedLocales: [
          Locale('de'),
          Locale('en'),
          Locale('es'),
        ],
      );

  static List<BlocProvider> blocProviders({
    required String otpEndpoint,
    required String otpGraphqlEndpoint,
    required MapConfiguration mapConfiguration,
  }) {
    return [
      BlocProvider<RouteTransportsCubit>(
        create: (context) => RouteTransportsCubit(otpGraphqlEndpoint),
      ),
      BlocProvider<SearchLocationsCubit>(
        create: (context) => SearchLocationsCubit(
          searchLocationRepository: DefaultSearchLocation(),
        ),
      ),
      BlocProvider<MapRouteCubit>(
        create: (context) => MapRouteCubit(otpEndpoint),
      ),
      BlocProvider<MapRouteCubit>(
        create: (context) => MapRouteCubit(otpEndpoint),
      ),
      BlocProvider<MapConfigurationCubit>(
        create: (context) => MapConfigurationCubit(mapConfiguration),
      ),
    ];
  }

  static RouterDelegate<Object> routerDelegate({
    required String appName,
    required String cityName,
    required String urlFeedback,
    String backgroundImage = 'assets/images/drawer-bg.jpg',
  }) {
    generateDrawer(String currentRoute) {
      return (BuildContext _) => TrufiDrawer(
            currentRoute,
            appName: appName,
            cityName: cityName,
            menuItems: defaultMenuItems,
            backgroundImage: backgroundImage,
          );
    }

    return RoutemasterDelegate(
      routesBuilder: (routeContext) {
        return RouteMap(
          onUnknownRoute: (_) => const Redirect(HomePage.route),
          routes: {
            HomePage.route: (route) => NoAnimationPage(
                  child: HomePage(
                    mapBuilder: (
                      mapContext,
                      trufiMapController,
                    ) {
                      return TrufiMapRoute(
                        trufiMapController: trufiMapController,
                      );
                    },
                    drawerBuilder: generateDrawer(HomePage.route),
                  ),
                ),
            TransportList.route: (route) => NoAnimationPage(
                  child: TransportList(
                    drawerBuilder: generateDrawer(TransportList.route),
                  ),
                ),
            TransportListDetail.route: (route) => NoAnimationPage(
                  child: TransportListDetail(
                    id: Uri.decodeQueryComponent(route.pathParameters['id']!),
                  ),
                ),
            SavedPlacesPage.route: (route) => NoAnimationPage(
                  child: SavedPlacesPage(
                    drawerBuilder: generateDrawer(SavedPlacesPage.route),
                  ),
                ),
            FeedbackPage.route: (route) => NoAnimationPage(
                  child: FeedbackPage(
                    urlFeedback: urlFeedback,
                    drawerBuilder: generateDrawer(FeedbackPage.route),
                  ),
                ),
            AboutPage.route: (route) => NoAnimationPage(
                  child: AboutPage(
                    drawerBuilder: generateDrawer(AboutPage.route),
                  ),
                ),
          },
        );
      },
    );
  }
}
