import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/colors.dart';
import 'constant/text_styles_value.dart';
import 'home/profile_page.dart';
import 'profile/bloc/profile_bloc.dart';
import 'profile/repositories/profile_repository.dart';
import 'profile/services/api_service.dart';
import 'profile/services/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final dio = DioClient.createDio();
  final apiService = ApiService(dio);
  final repository = ProfileRepository(apiService: apiService);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('kk'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: BlocProvider(
        create: (_) => ProfileBloc(repository: repository),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile App",
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        primaryColor: AppColors.secondary,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.px10blue,
        ),
      ),
      home: const ProfilePage(),
    );
  }
}