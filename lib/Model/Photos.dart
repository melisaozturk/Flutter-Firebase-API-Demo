
class Photos {
  int id, sol;
  Camera camera;
  Rover rover;
  String imgSrc, earthDate;

  Photos({
    this.id,
    this.sol,
    this.camera,
    this.rover,
    this.imgSrc,
    this.earthDate,
});

  Photos.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    sol = map['sol'];
    camera = Camera.fromMap(map['camera']);
    rover = Rover.fromMap(map['rover']);
    imgSrc = map['img_src'];
    earthDate = map['earth_date'];
  }
}

class Camera {
  int id, roverId;
  String name, fullName;

  Camera({
    this.id,
    this.roverId,
    this.name,
    this.fullName,
});

  Camera.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    roverId = map['rover_id'];
    name = map['name'];
    fullName = map['full_name'];
  }

}

class Rover {
  int id;
  String name, landingDate, launchDate, status;

  Rover({
    this.id,
    this.name,
    this.landingDate,
    this.launchDate,
    this.status,
  });

  Rover.fromMap(Map<String, dynamic> map) {
  id = map['id'];
  name = map['name'];
  landingDate = map['landing_date'];
  launchDate = map['launch_date'];
  status = map['status'];

  }


}
