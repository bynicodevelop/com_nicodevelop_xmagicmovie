import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/run_button/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/tool_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/view_manager_component.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/injector.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/notification_modal.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/crop_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  final VideoManager videoManager = getIt.get<VideoManager>();
  final UploadService uplaodService = getIt.get<UploadService>();
  final ConfigService configService = getIt.get<ConfigService>();

  runApp(App(
    videoManager: videoManager,
    uplaodService: uplaodService,
    configService: configService,
  ));
}

class App extends StatelessWidget {
  final VideoManager videoManager;
  final UploadService uplaodService;
  final ConfigService configService;

  const App({
    required this.videoManager,
    required this.uplaodService,
    required this.configService,
    super.key,
  });

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
          BlocProvider(
            create: (BuildContext context) => ModalBloc(
              closeDuration: kDefaultCloseDuration,
            ),
          ),
          BlocProvider<CropSelectorBloc>(
            create: (BuildContext context) => CropSelectorBloc(
              CropTool(),
              minCropWidth: 250,
              minCropHeight: 150,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => UploadBloc(
              uplaodService,
              configService,
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
          BlocProvider(
            create: (BuildContext context) => RunBloc(
              videoManager,
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
    return Scaffold(
      appBar: AppBar(
        actions: const [
          ToolComponent(),
        ],
      ),
      body: Stack(
        children: [
          const ViewManagerComponent(),
          Positioned(
            bottom: 50,
            right: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const NotificationModal(),
            ),
          ),
        ],
      ),
    );
  }
}
