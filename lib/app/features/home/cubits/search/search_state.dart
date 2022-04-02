part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.location = '',
    this.displaySearch = false,
  });

  final String location;
  final bool displaySearch;

  SearchState copyWith({
    String? location,
    bool? displaySearch,
  }) {
    return SearchState(
      location: location ?? this.location,
      displaySearch: displaySearch ?? this.displaySearch,
    );
  }

  @override
  List<Object> get props => [location, displaySearch];
}
