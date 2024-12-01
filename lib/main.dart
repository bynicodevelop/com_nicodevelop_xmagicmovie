import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/upload_file_component.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Magic Movie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CropSelectorBloc>(
            create: (BuildContext context) => CropSelectorBloc(
              minCropWidth: 250,
              minCropHeight: 150,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => UploadBloc(
              UplaodService(),
            ),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: UploadFileComponent(),
      ),
    );
  }
}
