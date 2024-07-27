import 'package:ecommerce_app/Core/Theme/theme.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/email_verification.dart';
import 'package:ecommerce_app/Features/Auth/Presentation/login_page.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/NavigationBlocs/navigation_bloc.dart';
import 'package:ecommerce_app/Features/Navigation/Presentation/home_page.dart';
import 'package:ecommerce_app/Features/OnBoardingScreen/Presentation/onboarding_screen.dart';
import 'package:ecommerce_app/Features/ProductDetails/Presentation/ProductsBloc/products_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'Features/Auth/Presentation/AuthBloc/auth_bloc.dart';
import 'Features/Settings/Presentaion/settingBloc/settings_bloc.dart';
import 'depencyInjection.dart';


  Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(MultiBlocProvider
    (providers: [
    BlocProvider(create:(_)=>injector<AuthBloc>()),
    BlocProvider(create:(_)=>injector<SettingsBloc>()),
    BlocProvider(create: (_)=>injector<ProductsBloc>()),
    BlocProvider(create: (_)=>injector<WishBloc>()),
  ], child: const MyApp(),

  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckIfFirstTimeEvent());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: TAppTheme.darkTheme,
      theme:TAppTheme.lightTheme,

      home: Scaffold(
        body: BlocConsumer<AuthBloc,AuthState>(builder: (_, state) {
          if(state is BannerLoading)
          {
            return const Center(child: CircularProgressIndicator());
          }

          if(state is IsFirstTime)
          {
            if(state.isFirstTime=='onBoardingPage') {
              return const OnBoardingPage();
            }
            else if(state.isFirstTime=='LoginPage') {

              return const LoginPage();
            }
            else if(state.isFirstTime=='HomePage') {
              return const HomePage();
            }
            else if(state.isFirstTime[state.isFirstTime.length-1]=='E') {

              return EmailVerifcation(email: state.isFirstTime.substring(0,state.isFirstTime.length-1),);
            }
          }

            return const LoginPage();

        }, listener: (context,state) {
          if(state is Failure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message))
            );
          }
        },),
      ),
    );
  }
}

