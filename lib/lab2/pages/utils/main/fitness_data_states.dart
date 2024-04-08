import 'package:my_project/lab2/logic/model/fitness_data.dart';

abstract class FitnessDataState {}

class FitnessDataInitial extends FitnessDataState {}

class FitnessDataLoading extends FitnessDataState {}

class FitnessDataLoaded extends FitnessDataState {
  final List<FitnessData> fitnessDataList;

  FitnessDataLoaded(this.fitnessDataList);
}

class FitnessDataError extends FitnessDataState {
  final String message;

  FitnessDataError(this.message);
}
