import 'package:get/get.dart';
import 'package:supabase_chat_app/app/routes/bindings/login_bindings.dart';
import 'package:supabase_chat_app/app/routes/routes_const.dart';
import 'package:supabase_chat_app/presentation/pages/login_page/login_page.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(
        name: RoutesConst.loginPage,
        page: () => const LoginPage(),
        binding: LoginBindings())
  ];
}
