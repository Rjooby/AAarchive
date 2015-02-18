(function() {

if (typeof Asteroids === "undefined"){
  window.Asteroids = {};
}

var Game = Asteroids.Game = function(){
  this.DIM_X = 1500;
  this.DIM_Y = 800;
  this.NUM_ASTEROIDS = 50;
  this.asteroids = [];
  this.bullets = [];
  this.addAsteroids();
  this.ship = new Asteroids.Ship({game: this, pos: this.randomPosition()});
}

Game.prototype.addAsteroids = function(){
  for (var i= 0; i < this.NUM_ASTEROIDS; i++){
    this.asteroids.push(new Asteroids.Asteroid({game: this, pos: this.randomPosition()}));
  }

}

Game.prototype.allObjects = function () {
  return this.asteroids.concat([this.ship]).concat(this.bullets);
}

Game.prototype.randomPosition = function(){
  var x = Math.random()*this.DIM_X;
  var y = Math.random()*this.DIM_Y;
  return [x,y];

}

Game.prototype.draw = function(ctx){
  // ctx.clearRect(0,0,this.DIM_X,this.DIM_Y);

  this.allObjects().forEach(function(el,idx,arr){
    el.draw(ctx);
  });

}

Game.prototype.moveObjects = function(){
  this.allObjects().forEach(function(el,idx,arr){
    el.move();
  })

}

Game.prototype.wrap = function (pos) {
  // Number#mod function in util.js for sane modulo
  var wx = pos[0].mod(this.DIM_X);
  var wy = pos[1].mod(this.DIM_Y);
  return [wx, wy];
}

Game.prototype.checkCollisions = function () {
  var game = this;
  game.allObjects().forEach(function (obj1, i, arr) {
    game.allObjects().forEach(function (obj2, j, arr) {
      if (obj1.isCollidedWith(obj2) && i !== j) {
        obj1.collideWith(obj2);
      }
    })
  })
}

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();

}

Game.prototype.isOutOfBounds = function (pos) {
  return (pos[0] > this.DIM_X || pos[1] > this.DIM_Y ||
          pos[0] < 0 || pos[1] < 0);
}

Game.prototype.remove = function(obj) {
  var objsarr;
  if (obj instanceof Asteroids.Asteroid) {
    objsarr = this.asteroids;
  }
  else if (obj instanceof Asteroids.Bullet) {
    objsarr = this.bullets;
  }
  var idx = objsarr.indexOf(obj);
  objsarr.splice(idx, 1);

}

}());
