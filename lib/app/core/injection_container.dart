import 'package:get_it/get_it.dart';
import 'package:radio_basic/app/features/home_page/presentation/cubit/home_page_cubit.dart';

final dependencia = GetIt.instance;
Future<void> init() async {
    dependencia.registerFactory(
    () => HomePageCubit(),
  );
}
