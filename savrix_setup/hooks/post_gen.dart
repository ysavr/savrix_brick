import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  Progress progress;

  Future<void> executeCommand(
    String message,
    Future<void> Function() fn,
  ) async {
    progress = context.logger.progress(message);
    await fn();
    progress.complete();
  }

  await executeCommand(
    'Adding dev dependencies',
    () => Process.run(
      'dart',
      [
        'pub',
        'add',
        '--dev',
        'build_runner: ^2.4.13',
        'envied_generator: ^0.5.4+1',
      ],
    ),
  );

  await executeCommand(
    'Adding dependencies',
    () => Process.run(
      'dart',
      [
        'pub',
        'add',
        'equatable: ^2.0.5',
        'intl:any',
        'shared_preferences: ^2.3.2',
        'get_it: ^8.0.2',
        'flutter_bloc: ^8.1.6',
        'bloc: ^8.1.4',
        'path_provider: ^2.1.5',
        'dio: ^5.7.0',
        'cached_network_image: ^3.4.1',
        'logger: ^2.4.0',
        'dropdown_button2: ^2.3.9',
        'another_flushbar: 1.12.30',
        'google_fonts: ^6.2.1',
        'flutter_svg: ^2.0.16',
        'overlay_support:',
        "flutter_alice:{'git':{'url':'https://git.tlab.co.id/tlab-internal-system/standart-pattern/mobile-kickstart/custom-libraries-or-tools/custom-alice'}}"
      ],
    ),
  );

  await executeCommand(
    'Running flutter clean',
    () => Process.run('flutter', ['clean']),
  );

  await executeCommand(
    'Running flutter pub get',
    () => Process.run('flutter', ['pub', 'get']),
  );

  await executeCommand(
    'Cleaning up previous build_runner outputs',
    () => Process.run(
      'dart',
      ['run', 'build_runner', 'clean'],
    ),
  );

  await executeCommand(
    'Running build_runner',
    () => Process.run(
      'dart',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    ),
  );

  context.logger.success('🎉 Brick generated successfully!');
  context.logger.info(
    '🧬 Do not forget to search the codebase for the TODOs and change them according to the project needs.'
    '\n🚧 Refer to readme for build your android project using flavor'
    '\n🤖 Change your android app name on strings.xml'
    '\n🤖 Adjust your own android flavor, you can refer to flavor-build.gradle'
    '\n🤖 Change keystore key on sign.gradle'
    '\n🐦 Declare your flutter env on .env file',
  );
}
