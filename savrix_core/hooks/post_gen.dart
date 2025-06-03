import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.success('🎉 Brick generated successfully!');
  context.logger.info(
    '🧬 Do not forget to search the codebase for the TODOs and change them according to the project needs.'
    '\n🚧 Refer to readme for build your android project'
    '\n🐦 Declare your flutter env on .env file'
    '\n🤖 Change keystore key on sign.gradle'
    '\n🍎 Change your "main.dart" path when build your ios app, Runner -> Targets -> Runner -> FLUTTER_TARGET',
  );
}
