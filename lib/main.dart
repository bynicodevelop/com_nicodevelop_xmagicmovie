import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/view_manager_component.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'X Magic Movie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
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
          BlocProvider(
            create: (BuildContext context) => ViewManagerBloc()
              ..add(
                const ViewManagerEvent(
                  kDefaultView,
                ),
              ),
          ),
          BlocProvider(
            create: (BuildContext context) => VideoBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => ToolBloc()
              ..add(
                OnPlayerToolEvent(),
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
      body: ViewManagerComponent(),
    );
  }
}
