import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rx_mvvm/infra/view_model_provider.dart';

import 'injector.dart';
import 'view_model.dart';

abstract class RxView<T extends ViewModelBase> extends StatefulWidget {
  // INavigator get navigator => getIt<INavigator>();
  final ViewModelProvider<T> _provider = ViewModelProvider.empty();
  T get viewModel => _provider.viewModel;

  RxView({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  /// Triggered when either [onVisibilityLost] or [onForegroundLost] is called.
  /// Equivalent to onPause() on Android or viewDidDisappear() on iOS.
  void onFocusLost() {}

  /// Triggered when either [onVisibilityGained] or [onForegroundGained] is called.
  /// Equivalent to onResume() on Android or viewDidAppear() on iOS.
  void onFocusGained() {}

  /// It means the widget is no longer visible within your app.
  void onVisibilityLost() {}

  /// It means the widget is now visible within your app.
  void onVisibilityGained() {}

  /// It means, for example, that the user sent your app to the background by opening
  /// another app or turned off the device\'s screen while your widget was visible.
  void onForegroundLost() {}

  /// It means, for example, that the user switched back to your app or turned the
  /// device's screen back on while your widget was visible.
  void onForegroundGained() {}

  void didChangeDependencies() {}
  void afterFirstLayout(BuildContext context) {}

  @override
  State<StatefulWidget> createState() => _ViewState<T>();

  void bindViewModel(T viewModel) {
    _provider.change(viewModel);
  }
}

class _ViewState<T extends ViewModelBase> extends State<RxView<T>> {
  late final T viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = Injector().get<T>();
    widget.bindViewModel(viewModel);

    viewModel.binds(widget);
    viewModel.onInit();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) widget.afterFirstLayout(context);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: widget.onFocusLost,
      onFocusGained: widget.onFocusGained,
      onVisibilityLost: widget.onVisibilityLost,
      onVisibilityGained: widget.onVisibilityGained,
      onForegroundLost: widget.onForegroundLost,
      onForegroundGained: widget.onForegroundGained,
      child: widget.build(context),
    );
  }

  @override
  void didUpdateWidget(covariant RxView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    viewModel.binds(widget);
    widget.bindViewModel(viewModel);

    viewModel.onUpdate();
  }

  @override
  Future<void> dispose() async {
    await viewModel.close();
    viewModel.onDispose();
    super.dispose();
  }
}
