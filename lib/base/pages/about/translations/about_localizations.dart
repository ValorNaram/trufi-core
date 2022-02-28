
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'about_localizations_de.dart';
import 'about_localizations_en.dart';
import 'about_localizations_es.dart';
import 'about_localizations_fr.dart';
import 'about_localizations_it.dart';
import 'about_localizations_pt.dart';

/// Callers can lookup localized strings with an instance of AboutLocalization returned
/// by `AboutLocalization.of(context)`.
///
/// Applications need to include `AboutLocalization.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'translations/about_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AboutLocalization.localizationsDelegates,
///   supportedLocales: AboutLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AboutLocalization.supportedLocales
/// property.
abstract class AboutLocalization {
  AboutLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AboutLocalization of(BuildContext context) {
    return Localizations.of<AboutLocalization>(context, AboutLocalization)!;
  }

  static const LocalizationsDelegate<AboutLocalization> delegate = _AboutLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt')
  ];

  /// A short marketing sentence that describes the app
  ///
  /// In pt, this message translates to:
  /// **'The {appName} for {city} enhances your travel experience on trufis and buses, and helps to move around {city}.\n\nNeed to go somewhere and don\'t know which trufi or bus to take?\nWith Trufi App it\'s easy! \n\nTrufi Association is an international NGO that promotes easier access to public transport. In many cities there are no official maps, apps or timetables. We complete them, and sometimes even draw routes from scratch. Our apps help everyone find the best way to get from point A to point B within their cities. A well-designed transportation system contributes to greater sustainability, cleaner air and a better quality of life.\n\nWe love La Llajta and public transportation, that\'s why Trufi Association created this app to make it easy for {city} commuters and anyone else to get around {city}.\n\nPlease help us make {appName} better by volunteering with us. We need mappers, developers, planners, testers, and many other hands. Please contact our team via email feedback@trufi.app.\n'**
  String aboutCollapseContent(Object appName, Object city);

  /// No description provided for @aboutCollapseTitle.
  ///
  /// In pt, this message translates to:
  /// **'We are the coolest group ever! Any other questions?'**
  String get aboutCollapseTitle;

  /// Text displayed on the about page
  ///
  /// In pt, this message translates to:
  /// **'Somos uma equipe boliviana e internacional de pessoas que amam e apoiam o transporte público.\n\nNós desenvolvemos este aplicativo para facilitar o uso do sistema de transporte em Cochabamba e arredores.'**
  String get aboutContent;

  /// Button label to show licenses
  ///
  /// In pt, this message translates to:
  /// **'Licenças'**
  String get aboutLicenses;

  /// A note about open source
  ///
  /// In pt, this message translates to:
  /// **'Este aplicativo é lançado como código aberto no GitHub. Sinta-se livre para contribuir ou trazê-lo para sua própria cidade.'**
  String get aboutOpenSource;

  /// Menu item that shows the about page
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get menuAbout;

  /// A short marketing sentence that describes the app
  ///
  /// In pt, this message translates to:
  /// **'Transporte público em {city}'**
  String tagline(Object city);

  /// The application's version
  ///
  /// In pt, this message translates to:
  /// **'Versão {version}'**
  String version(Object version);
}

class _AboutLocalizationDelegate extends LocalizationsDelegate<AboutLocalization> {
  const _AboutLocalizationDelegate();

  @override
  Future<AboutLocalization> load(Locale locale) {
    return SynchronousFuture<AboutLocalization>(lookupAboutLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AboutLocalizationDelegate old) => false;
}

AboutLocalization lookupAboutLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AboutLocalizationDe();
    case 'en': return AboutLocalizationEn();
    case 'es': return AboutLocalizationEs();
    case 'fr': return AboutLocalizationFr();
    case 'it': return AboutLocalizationIt();
    case 'pt': return AboutLocalizationPt();
  }

  throw FlutterError(
    'AboutLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
