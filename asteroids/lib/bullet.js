(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function (hash) {
    hash["color"] = Asteroids.MovingObject.randomColor();
    hash["radius"] = Bullet.RADIUS;
    Asteroids.MovingObject.call(this, hash);
  }

    // Bullet.COLOR = Asteroids.MovingObject.randomColor();
    Bullet.RADIUS = 3;

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

  Bullet.prototype.isWrappable = false;

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Asteroid) { // FU JS
      this.game.remove(otherObject);
      this.game.remove(this);
    }

  }

}());
