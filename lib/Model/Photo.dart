
class Photo {
  int id;
  int sol;
  Camera camera;
  String img_src;
  String earth_date;
  Rover rover;
}

class Camera {
  int id;
  String name;
  int rover_id;
  String full_name;
}

class Rover {
  int id;
  String name;
  String landing_date;
  String launch_date;
  String status;
}
