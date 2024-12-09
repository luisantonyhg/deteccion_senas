import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/reset_password_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/detection_screen.dart';
import '../screens/real_time_camera_screen.dart';
import '../screens/detection_history_screen.dart';
import '../screens/training_screen.dart';
import '../screens/VerifyTokenScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/reset_password': (context) => ResetPasswordScreen(),
      '/profile': (context) => ProfileScreen(),
      '/detection': (context) => DetectionScreen(),
      '/real_time_camera': (context) => RealTimeCameraScreen(),
      '/history': (context) => DetectionHistoryScreen(),
      '/training': (context) => TrainingScreen(),
      '/verificartoken' : (context) => VerifyTokenScreen(),
    };
  }
}
