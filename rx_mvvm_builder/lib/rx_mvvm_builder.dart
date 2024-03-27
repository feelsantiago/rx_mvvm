library rx_mvvm_builder;

import 'package:build/build.dart';
import 'package:rx_mvvm_builder/src/view_model_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder viewModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([ViewModelGenerator()], 'vm_generator');
