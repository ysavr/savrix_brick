import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final gitignore = File('.gitignore');
  const developGenerated = '\nlib/core/env/develop_env.g.dart';
  const stagGenerated = '\nlib/core/env/stag_env.g.dart';
  const productionGenerated = '\nlib/core/env/prod_env.g.dart';

  if (gitignore.existsSync()) {
    // Append paths if not already present
    if (!gitignore.readAsStringSync().contains(developGenerated.trim())) {
      gitignore.writeAsStringSync(developGenerated, mode: FileMode.append);
    }
    if (!gitignore.readAsStringSync().contains(stagGenerated.trim())) {
      gitignore.writeAsStringSync(stagGenerated, mode: FileMode.append);
    }
    if (!gitignore.readAsStringSync().contains(productionGenerated.trim())) {
      gitignore.writeAsStringSync(productionGenerated, mode: FileMode.append);
    }
    context.logger.success('🎉 Added env files to .gitignore');
  } else {
    gitignore.writeAsStringSync('$developGenerated$stagGenerated$productionGenerated');
    context.logger.success('🎉 Created .gitignore and added env files');
  }
}
