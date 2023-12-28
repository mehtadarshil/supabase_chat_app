import 'package:get/get.dart';
import 'package:supabase_chat_app/presentation/pages/login_page/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
