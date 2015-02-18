(function() {

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (hash) {
    this.COLOR = "#FFF";
    this.RADIUS = 20;

    hash["vel"] = [0,0];
    hash["color"] = this.COLOR;
    hash["radius"] = this.RADIUS;
    Asteroids.MovingObject.call(this, hash);
  }

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.img.src = 'jonathan.png';

  Ship.prototype.relocate = function() {
    this.pos = this.game.randomPosition();
    this.vel = [0,0];
  }

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  }

  Ship.prototype.fireBullet = function () {
    var speed = Math.sqrt(Math.pow(this.vel[0], 2) + Math.pow(this.vel[1], 2));
    var velocity = [5 * (this.vel[0]/ speed), 5 * (this.vel[1] / speed)];
    game.bullets.push(new Asteroids.Bullet({game: this.game, pos: this.pos, vel: velocity }))
  }

}());
