import 'package:clean_arch/common/app_colors.dart';
import 'package:clean_arch/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/pages/person_screen.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(create: (context) => di.sl<PersonListCubit>()..loadPerson()),
          BlocProvider<PersonSearchBloc>(create: (context) => di.sl<PersonSearchBloc>()),
        ], 
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ),
    );
  }
}




