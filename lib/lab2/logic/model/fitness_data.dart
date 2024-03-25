class FitnessData {
  int steps;
  int caloriesBurned;

  FitnessData({
    required this.steps,
    required this.caloriesBurned,
  });

  Map<String, dynamic> toJson() => {
        'steps': steps,
        'caloriesBurned': caloriesBurned,
      };

  static FitnessData fromJson(Map<String, dynamic> json) => FitnessData(
        steps: json['steps'] as int,
        caloriesBurned: json['caloriesBurned'] as int,
      );
}
