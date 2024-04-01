import 'package:my_project/lab2/logic/model/fitness_data.dart';

abstract class FitnessDataEvent {}

class LoadFitnessData extends FitnessDataEvent {}

class AddFitnessData extends FitnessDataEvent {
  final FitnessData fitnessData;

  AddFitnessData(this.fitnessData);

  List<Object> get props => [fitnessData];

}

class DeleteFitnessData extends FitnessDataEvent {
  final int id;

  DeleteFitnessData(this.id);
}
