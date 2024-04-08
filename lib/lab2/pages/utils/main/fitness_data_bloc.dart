import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_project/lab2/logic/service/tracker/fitness_data_service.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_events.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_states.dart';

class FitnessDataBloc extends Bloc<FitnessDataEvent, FitnessDataState> {
  final FitnessDataService _fitnessDataService;


  FitnessDataBloc(this._fitnessDataService) : super(FitnessDataInitial()) {
    on<LoadFitnessData>((event, emit) async {
      emit(FitnessDataLoading());
      try {
        final data = await _fitnessDataService.loadFitnessDataList();
        emit(FitnessDataLoaded(data));
      } catch (e) {
        emit(FitnessDataError(e.toString()));
      }
    });

    on<AddFitnessData>((event, emit) async {
      try {
        await _fitnessDataService.addFitnessData(event.fitnessData);
        add(LoadFitnessData());
      } catch (e) {
        emit(FitnessDataError(e.toString()));
      }
    });

    on<DeleteFitnessData>((event, emit) async {
      try {
        await _fitnessDataService.deleteFitnessData(event.id);
        add(LoadFitnessData());
      } catch (e) {
        emit(FitnessDataError(e.toString()));
      }
    });
  }
}
