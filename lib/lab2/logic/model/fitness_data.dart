class FitnessData {
  int id;
  String steps;
  String caloriesBurned;

  FitnessData({
    required this.id,
    required this.steps,
    required this.caloriesBurned,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'steps': steps,
      'caloriesBurned': caloriesBurned,
    };
  }

  static FitnessData fromJson(Map<String, dynamic> map) {
    return FitnessData(
      id: map['id'] as int,
      steps: map['steps'].toString(),
      caloriesBurned: map['caloriesBurned'].toString(),
    );
  }
}
