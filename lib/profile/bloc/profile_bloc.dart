import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());

      try {
        final profile = await repository.getProfile();
        emit(ProfileLoaded(profile: profile));
      } on DioException catch (e) {
        emit(ProfileError(message: 'Dio error: ${e.message}'));
      } catch (e) {
        emit(ProfileError(message: 'Unexpected error: $e'));
      }
    });
  }
}