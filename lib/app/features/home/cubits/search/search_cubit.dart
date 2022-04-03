import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  Future<void> toggleSearch() async {
    emit(state.copyWith(displaySearch: !state.displaySearch));
  }

  void changeLocation(String value) {
    emit(state.copyWith(location: value));
  }
}
