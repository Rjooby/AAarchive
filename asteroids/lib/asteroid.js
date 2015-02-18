(function() {

if (typeof Asteroids === "undefined") {
  window.Asteroids = {};
}

var Asteroid = Asteroids.Asteroid = function (hash) {
  hash["vel"] = Asteroids.Util.randomVec(Asteroid.SPEED);
  hash["color"] = Asteroids.MovingObject.randomColor();
  hash["radius"] = Asteroid.RADIUS;
  Asteroids.MovingObject.call(this, hash);
}
  Asteroid.COLOR = "#000000";
  Asteroid.RADIUS = 10;
  Asteroid.SPEED = 3;

Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

Asteroid.prototype.collideWith = function (otherObject) {
  if (otherObject instanceof Asteroids.Ship) { // FU JS
    otherObject.relocate();

  }

}


}());
