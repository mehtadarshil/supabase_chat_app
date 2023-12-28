import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_chat_app/app/routes/routes_const.dart';
import 'app/config/app_colors.dart';
import 'app/di/app_base_component.dart';
import 'app/routes/routes.dart';
import 'presentation/widgets/custom_progress_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.whiteColor,
  ));
  await Get.updateLocale(const Locale("en"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    AppComponentBase.instance.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.locale,
      fallbackLocale: const Locale("en"),
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages,
      initialRoute: RoutesConst.loginPage,
      builder: (context, widget) {
        return Stack(
          children: <Widget>[
            StreamBuilder<bool>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  return IgnorePointer(
                      ignoring: snapshot.data ?? false,
                      child: SafeArea(child: widget!));
                }),
            StreamBuilder<bool?>(
                initialData: true,
                stream: AppComponentBase
                    .instance.networkManage.internetConnectionStream,
                builder: (context, snapshot) {
                  return SafeArea(
                    child: AnimatedContainer(
                        height: snapshot.data ?? false ? 0 : 100,
                        duration: const Duration(milliseconds: 400),
                        color: AppColors.primaryRedColor,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Center(
                              child: Text(
                            "no_internet".tr,
                          )),
                        )),
                  );
                }),
            StreamBuilder<bool?>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return Container(
                        color: Colors.black.withOpacity(0.4),
                        child: const Center(child: CustomProgressDialog()));
                  } else {
                    return const Offstage();
                  }
                })
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    AppComponentBase.instance.dispose();
    super.dispose();
  }
}
