class LastSopTotalElapsedTimeResponse {
  LastSopTotalElapsedTime? data;

  LastSopTotalElapsedTimeResponse({required this.data});

  factory LastSopTotalElapsedTimeResponse.from(List<dynamic> data) {
    return LastSopTotalElapsedTimeResponse(
      data: data.isEmpty ? null : LastSopTotalElapsedTime.from(data),
    );
  }
}

class LastSopTotalElapsedTime {
  int lastSop;
  int elapsedTimeInSeconds;
  String status;

  LastSopTotalElapsedTime({
    required this.lastSop,
    required this.elapsedTimeInSeconds,
    required this.status,
  });

  factory LastSopTotalElapsedTime.from(List<dynamic> data) {
    int elapsedTimeInSeconds = data.fold(
      0,
      (sum, json) => sum + (json['duration_in_seconds'] as num).toInt(),
    );
    return LastSopTotalElapsedTime(
      lastSop: (data.last['sop'] as num).toInt(),
      elapsedTimeInSeconds: elapsedTimeInSeconds,
      status: data.isEmpty ? '' : data.last['status'] as String,
    );
  }
}
