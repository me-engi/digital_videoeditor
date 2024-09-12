// Import the widget you are using
import 'package:editor/widgets/secondrow/secondparteditor/allsecondparteditorwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider for mobile and desktop

Future<void> initializeHive() async {
  try {
    // Initialize Hive based on the platform
    if (!kIsWeb) {
      // For mobile or desktop platforms
      final directory = await getApplicationDocumentsDirectory(); // Get the application documents directory
      await Hive.initFlutter(directory.path); // Use path from Directory object
    } else {
      // For web platforms
      await Hive.initFlutter(); // No specific directory needed for web
    }

    // Open the boxes used in your app
    await Hive.openBox('mediaBox');
    await Hive.openBox('layersBox'); // Add any additional boxes used in your app
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive(); // Ensure Hive is initialized before running the app

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Editor',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SecondPartCombinedWidget(), // Your main widget
    );
  }
}
