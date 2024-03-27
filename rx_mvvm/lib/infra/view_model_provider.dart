import 'view_model.dart';

class ViewModelProvider<T extends ViewModelBase> {
  T? _viewModel;

  ViewModelProvider(this._viewModel);
  ViewModelProvider.empty();

  T get viewModel {
    assert(_viewModel != null);
    return _viewModel!;
  }

  change(T viewModel) {
    this._viewModel = viewModel;
  }
}
