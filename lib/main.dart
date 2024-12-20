import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_new/button_new_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_open_file/bloc/open_file_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_project/bloc/project_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/loader/bloc/loader_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/loader/loader_modal.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/notification/bloc/modal_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/modals/notification/notification_modal.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/tool_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/upload_file/bloc/upload_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/bloc/view_manager_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/view_manager/view_manager_component.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/injector.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/services/uplaod_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/crop_tool.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/project.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/run.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  final FileManager fileManager = getIt.get<FileManager>();
  final VideoManager videoManager = getIt.get<VideoManager>();
  final UploadService uplaodService = getIt.get<UploadService>();
  final ConfigService configService = getIt.get<ConfigService>();

  runApp(App(
    fileManager: fileManager,
    videoManager: videoManager,
    uplaodService: uplaodService,
    configService: configService,
  ));
}

class App extends StatelessWidget {
  final FileManager fileManager;
  final VideoManager videoManager;
  final UploadService uplaodService;
  final ConfigService configService;

  const App({
    required this.fileManager,
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
          BlocProvider(
            create: (BuildContext context) => LoaderBloc(),
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
              videoManager,
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
            create: (BuildContext context) => ToolBloc(
              Tool(),
            )..add(
                OnResetToolEvent(),
              ),
          ),
          BlocProvider(
            create: (BuildContext context) => RunBloc(
              Run(videoManager: videoManager),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ProjectsBloc(
              Project(
                fileManager,
                configService,
                videoManager,
              ),
            )..add(const LoadProjects()),
          ),
          BlocProvider(
            create: (BuildContext context) => ProjectBloc(
              Project(
                fileManager,
                configService,
                videoManager,
              ),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ProjectDeletionBloc(
              Project(
                fileManager,
                configService,
                videoManager,
              ),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => OpenFileBloc(
              videoManager: videoManager,
            ),
          ),
          RepositoryProvider<VideoManager>.value(
            value: videoManager,
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
    return LoaderModal(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: const ButtonNewComponent(),
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
      },
    );
  }
}
