import 'AdService.dart';
import 'ExamWidget.dart';
import 'MyTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'SettingWidget.dart';

final RouteObserver<PageRoute> routeObserver =
RouteObserver<PageRoute>(); // <-- ここでrouteObserverを定義

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorObservers: [routeObserver],
              home: _MyAppPage(),
              theme: lightTheme,
              darkTheme: darkTheme);
        });
  }
}

class _MyAppPage extends StatefulWidget {
  _MyAppPage({Key? key}) : super(key: key);

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<_MyAppPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text('チー牛診断',
              style: Theme.of(context).appBarTheme.titleTextStyle),
          actions: [
            IconButton(
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingWidget()))
              },
              icon: Icon(Icons.settings, size: 25.sp),
            )
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top:60.w, right: 20.h, left: 20.h, bottom: 0),
                    child: Text("あなたのチー牛レベルを測ろう。",style: Theme.of(context).textTheme.bodyText2)),
                Expanded(
                  child:
                  Padding(
                    padding: EdgeInsets.all(50.w),
                    child: Image(
                        image: AssetImage('assets/images/cheese.jpg')),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top:0, right: 20.h, left: 20.h, bottom: 0),
                    child: Text("質問に答えて診断！",style: Theme.of(context).textTheme.bodyText2)),

                Container(
                  width: double.maxFinite,
                  height: 85.h,
                  padding: EdgeInsets.only(
                      top: 10.w, right: 30.h, left: 30.h, bottom: 20.w),
                  child: OutlinedButton.icon(
                    icon: Icon(
                      Icons.analytics,
                      size: 30.sp,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ExamWidget()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                      side: BorderSide(
                          width: 2.w, color: Theme.of(context).primaryColorLight),
                    ),
                    label:
                    Text("診断する", style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.w, bottom: 0.w),
                  child: AdService.getAdd(context),
                )
              ]),
        ));
  }
}
