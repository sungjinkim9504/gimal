import 'package:go_router/go_router.dart';
import '../../features/diary/screens/diary_list_screen.dart';
import '../../features/diary/screens/diary_write_screen.dart';
import '../../features/diary/screens/diary_detail_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: DiaryListScreen.routeName,
        builder: (_, __) => const DiaryListScreen(),
      ),
      GoRoute(
        path: '/diary/write',
        name: DiaryWriteScreen.routeName,
        builder: (_, state) {
          final args = state.extra as DiaryWriteArgs;
          return DiaryWriteScreen(
            date: args.date,
            existingEntry: args.existingEntry,
          );
        },
      ),
      GoRoute(
        path: '/diary/:id',
        name: DiaryDetailScreen.routeName,
        builder: (_, state) =>
            DiaryDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/settings',
        name: SettingsScreen.routeName,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
  );
}
